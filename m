Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUAHToo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUAHTlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:41:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52087 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266281AbUAHTk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:40:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <1aJdi-7TH-25@gated-at.bofh.it>
	<m37k054uqu.fsf@averell.firstfloor.org>
	<Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
	<20040106040546.GA77287@colin2.muc.de>
	<Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
	<20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi>
	<20040106094442.GB44540@colin2.muc.de>
	<Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
	<20040106153706.GA63471@colin2.muc.de>
	<m1brpgn1c3.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
	<m13casmk28.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401062116230.12602@home.osdl.org>
	<m1smirlppt.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401070803320.12602@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Jan 2004 12:34:48 -0700
In-Reply-To: <Pine.LNX.4.58.0401070803320.12602@home.osdl.org>
Message-ID: <m1smiqi693.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> At some point, the _correct_ answer may be: don't do complex things, and
> write a bootable floppy (without any OS at all, or a really minimal one)  
> to do BIOS rom updates.

ROM chips fall into the linux mtd layer quite cleanly, and they are
just quirky enough they need someplace where lots of eyes look at the
code, and lots of people use the code.  And the linux mtd layer
appears to be that place.

I have had enough success in actually using the linux kernel, for
flashing ROMS, it is becoming worth while to actually fix up the
last couple of annoying cases.  

Plus I'm close to the point of finding some value in jffs2 and the
other flash filesystems, at which point I will need to use the mtd
layer anyway.

Eric
