Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSBDSXi>; Mon, 4 Feb 2002 13:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSBDSXX>; Mon, 4 Feb 2002 13:23:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32531 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284732AbSBDSXE>; Mon, 4 Feb 2002 13:23:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to check the kernel compile options ?
Date: 4 Feb 2002 10:22:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3mjhc$qba$1@cesium.transmeta.com>
In-Reply-To: <3C5EB070.4370181B@uni-mb.si> <3C5EB070.4370181B@uni-mb.si> <4.3.2.7.2.20020204124812.00aec590@mail.osagesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4.3.2.7.2.20020204124812.00aec590@mail.osagesoftware.com>
By author:    David Relson <relson@osagesoftware.com>
In newsgroup: linux.dev.kernel
> 
> I remember discussion of that patch some time ago and the main complaint 
> about it was that it increases the size of the kernel, i.e. vmlinuz.  Why 
> not put the need info in a module?  Doing that would enable the following 
> command:
> 
>          zgrep CONFIG_PROC /lib/modules/`uname -r`/config.gz
> 
> (or something similar).
> 

Uhm, no.  The problem with it is that you're using kernel memory
because you're not willing to manage userspace competently, so modules
(in fact, *using modules at all*) would be right out.

I have had in my /sbin/installkernel a clause to save .config as
config-<foo> when I install vmlinuz-<foo>; I believe anyone not doing
that[1] is, quite frankly, a moron.

	-hpa

[1] or rather, not doing it without knowing exactly why they aren't --
sometimes there are good reasons for doing so.
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
