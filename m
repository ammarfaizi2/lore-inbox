Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278286AbRJWVA4>; Tue, 23 Oct 2001 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278287AbRJWVAr>; Tue, 23 Oct 2001 17:00:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12811 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278286AbRJWVA0>; Tue, 23 Oct 2001 17:00:26 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Q] pivot_root and initrd
Date: 23 Oct 2001 14:00:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9r4lps$hbo$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L.0110231759020.3690-100000@imladris.surriel.com> <ujkB7.3878$1%5.659642574@newssvr17.news.prodigy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <ujkB7.3878$1%5.659642574@newssvr17.news.prodigy.com>
By author:    davidsen@tmr.com (bill davidsen)
In newsgroup: linux.dev.kernel
> 
> I wasn't really asking about changing root after the system is up, the
> part needed is the uncompressing of the filesystem into a ramdisk root f/s
> or some such. After that it's pretty much open to any of several techniques.
> 
> Getting the modules loaded to support the root f/s and run a little rc
> file to get things going is the bootstrap operation, and that's where
> initrd is vital. You really don't want to build a kernel for every
> machine if you have more than a few! One kernel and a few config and
> initrd files is vastly easier.
> 
> What replaces the initial step?
> 

We will definitely have initrd or initramfs to do this (initramfs is
using the initrd protocol to populate a ramfs from a tar/cpio image.)
However, when it comes up, it will be the root as far as the kernel is
concerned, and run /sbin/init (unless overridden on the kernel command
line, of course) like any other boot.  None of this change_root and
/linuxrc special casing garbage.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
