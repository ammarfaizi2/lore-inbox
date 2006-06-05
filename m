Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751203AbWFEPs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWFEPs0 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 11:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWFEPs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 11:48:26 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:17575 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751193AbWFEPsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 11:48:25 -0400
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <20060605153420.GB26666@flint.arm.linux.org.uk>
References: <1149392479501-git-send-email-htejun@gmail.com>
	 <20060604204444.GF4484@flint.arm.linux.org.uk>
	 <20060604222347.GG4484@flint.arm.linux.org.uk>
	 <1149517656.3489.15.camel@mulgrave.il.steeleye.com>
	 <20060605144456.GA26666@flint.arm.linux.org.uk>
	 <1149521085.3489.24.camel@mulgrave.il.steeleye.com>
	 <20060605153420.GB26666@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 10:47:40 -0500
Message-Id: <1149522460.3489.26.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 16:34 +0100, Russell King wrote:
> What has zero copy (your reply) got to do with faulting pages into
> userspace (my message).  I'm sorry, I don't understand why you've
> brought this up.

The zero copy case is the case where we end up with user and kernel
mappings simultaneously on the page.  The nopage (or fault) case is
where we end up with them sequentially.  Both cases actually require the
same cache treatment, but it's easiest to understand in the zero copy
case.

James


