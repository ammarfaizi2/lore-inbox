Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751201AbWFEPsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWFEPsz (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 11:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWFEPsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 11:48:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17417 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751201AbWFEPsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 11:48:54 -0400
Date: Mon, 5 Jun 2006 16:48:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
Message-ID: <20060605154837.GD26666@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
	Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
	jgarzik@pobox.com, mattjreimer@gmail.com,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <1149392479501-git-send-email-htejun@gmail.com> <20060604204444.GF4484@flint.arm.linux.org.uk> <20060604222347.GG4484@flint.arm.linux.org.uk> <1149517656.3489.15.camel@mulgrave.il.steeleye.com> <20060605144456.GA26666@flint.arm.linux.org.uk> <1149521085.3489.24.camel@mulgrave.il.steeleye.com> <20060605153420.GB26666@flint.arm.linux.org.uk> <1149522460.3489.26.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149522460.3489.26.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 10:47:40AM -0500, James Bottomley wrote:
> On Mon, 2006-06-05 at 16:34 +0100, Russell King wrote:
> > What has zero copy (your reply) got to do with faulting pages into
> > userspace (my message).  I'm sorry, I don't understand why you've
> > brought this up.
> 
> The zero copy case is the case where we end up with user and kernel
> mappings simultaneously on the page.  The nopage (or fault) case is
> where we end up with them sequentially.  Both cases actually require the
> same cache treatment, but it's easiest to understand in the zero copy
> case.

When does the zero copy case occur?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
