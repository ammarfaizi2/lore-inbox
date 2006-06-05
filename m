Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751220AbWFEQTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWFEQTl (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWFEQTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:19:41 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:50859 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751220AbWFEQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:19:39 -0400
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <20060605154837.GD26666@flint.arm.linux.org.uk>
References: <1149392479501-git-send-email-htejun@gmail.com>
	 <20060604204444.GF4484@flint.arm.linux.org.uk>
	 <20060604222347.GG4484@flint.arm.linux.org.uk>
	 <1149517656.3489.15.camel@mulgrave.il.steeleye.com>
	 <20060605144456.GA26666@flint.arm.linux.org.uk>
	 <1149521085.3489.24.camel@mulgrave.il.steeleye.com>
	 <20060605153420.GB26666@flint.arm.linux.org.uk>
	 <1149522460.3489.26.camel@mulgrave.il.steeleye.com>
	 <20060605154837.GD26666@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 11:16:42 -0500
Message-Id: <1149524202.3489.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 16:48 +0100, Russell King wrote:
> When does the zero copy case occur?

Almost all user initiated I/O.  Glibc tends to implement this as mmap
internally.

James


