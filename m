Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWJDVfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWJDVfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWJDVfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:35:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50826 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751151AbWJDVfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:35:08 -0400
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Randy Dunlap <rdunlap@xenotime.net>,
       akpm <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490610041302i2bc4d1aave8fbc3e6c153759b@mail.gmail.com>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
	 <20061002213809.7a3f995f.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>
	 <20061003092339.999d0011.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030933250.3952@g5.osdl.org>
	 <20061003094926.0e99d13f.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030950230.3952@g5.osdl.org>
	 <9a8748490610041224h7de321r6507a0d9e99ad015@mail.gmail.com>
	 <Pine.LNX.4.64.0610041235380.3952@g5.osdl.org>
	 <9a8748490610041302i2bc4d1aave8fbc3e6c153759b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 23:00:40 +0100
Message-Id: <1159999240.25772.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 22:02 +0200, ysgrifennodd Jesper Juhl:
> > > /etc/rc.d/rc.sshd: line 4: 1491 Illegal instruction    /usr/sbin/sshd
> >
> > Ok, I bet you have your sshd compiled to use MMX instructions
> > unconditionally.
> >
> Probably, I haven't checked.

Or we aren't correctly masking all the other cpuid bits we should in
this case..

