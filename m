Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWGKRqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWGKRqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWGKRqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:46:14 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:18517 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751146AbWGKRqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:46:13 -0400
Message-ID: <44B3E3E0.1050100@tls.msk.ru>
Date: Tue, 11 Jul 2006 21:46:08 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de>
In-Reply-To: <20060711164040.GA16327@suse.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
[]
> To create the initrd you needed a loop file, at least for ext2, minix etc.

It's just damn trivial to pack your files into cpio archive and gzip it.
No need for any filesystem code in kernel, be it ext2, minix or other.

initrd => initramfs conversion (what you said I "force" on users) is
to switch from loop+whatever-fs-du-jur to plain dirrectory and cpio,
and to add the final mount+run_init into the initrd script.  And after
that's done, everything becomes good... ;)

> But so far, the arguments are not convincing that kinit has to be in the
> kernel tree.

Here, I agree.

/mjt
