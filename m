Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUIENC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUIENC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUIENC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:02:56 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14491 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266616AbUIENCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:02:55 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409042304200.24528@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
	 <Pine.LNX.4.58.0409040145240.25475@skynet>
	 <20040904102914.B13149@infradead.org>
	 <41398EBD.2040900@tungstengraphics.com>
	 <20040904104834.B13362@infradead.org>
	 <413997A7.9060406@tungstengraphics.com>
	 <20040904112535.A13750@infradead.org>
	 <4139995E.5030505@tungstengraphics.com>
	 <20040904120352.B14037@infradead.org>
	 <Pine.LNX.4.58.0409041207060.25475@skynet>
	 <20040904114243.GC2785@redhat.com>
	 <1094333738.6575.393.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409042304200.24528@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094385611.1081.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 13:00:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-04 at 23:06, Dave Airlie wrote:
> we also have out of kernel DRM drivers for mach64 and savage that would
> pose security issues if shipped, so we can't develop them in-kernel....
> (another reason for the CVS tree)...

I still think this is actually a bad decision. You can develop them in
kernel providing you put

	if(!capable(CAP_SYS_RAWIO))
		return -EPERM

in the client side open for these devices. At that point root can use it
happily but nobody else can. You can test it, you can share it upstream
and you can motivate people to fix it.

Alan

