Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSHIGD0>; Fri, 9 Aug 2002 02:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSHIGD0>; Fri, 9 Aug 2002 02:03:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318159AbSHIGDZ>; Fri, 9 Aug 2002 02:03:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
Date: 8 Aug 2002 23:06:43 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aivm5j$rmt$1@cesium.transmeta.com>
References: <UTC200208081822.g78IM2r23833.aeb@smtp.cwi.nl> <3.0.5.32.20020808153603.01476050@pop-server.san.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3.0.5.32.20020808153603.01476050@pop-server.san.rr.com>
By author:    John Coffman <johninsd@san.rr.com>
In newsgroup: linux.dev.kernel
> 
> The lilo boot loader must use the BIOS as its disk driver to access the
> disk at boot time.  It may be directed to use one of three addressing modes:
> 
>   geometric - use int 13h, fn 2 (CHS read)
>   linear - convert 24-bit disk address to CHS, use int 13h, fn 2 as above.
>   lba32 - 32-bit disk addresses; IF AVAILABLE, use int 13h, fn 42h (EDD
> packet call) to read disk; else convert disk address to CHS, use int 13h,
> fn 2 as above.
> 
> All CHS addressing is subject to the 1024 cylinder limit.  If a 'linear' or
> 'lba32' address is converted to CHS, the head/sector information need for
> the conversion is obtained with int 13h, fn 8 (Get drive parameters).
> 

Why support geometric at all?  Either "linear" or "lba32" should work
on all systems (otherwise (Win)DOS won't work either.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
