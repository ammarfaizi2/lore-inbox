Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTBCS6F>; Mon, 3 Feb 2003 13:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbTBCS6F>; Mon, 3 Feb 2003 13:58:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22791 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266977AbTBCS6E>; Mon, 3 Feb 2003 13:58:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: futimes()?
Date: 3 Feb 2003 11:07:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1mel3$fug$1@cesium.transmeta.com>
References: <b1htmi$9r6$1@cesium.transmeta.com> <20030202120752.GK5239@riesen-pc.gr05.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030202120752.GK5239@riesen-pc.gr05.synopsys.com>
By author:    Alex Riesen <alexander.riesen@synopsys.COM>
In newsgroup: linux.dev.kernel
>
> H. Peter Anvin, Sun, Feb 02, 2003 02:53:22 +0100:
> > In the general vein of avoiding security holes by using file
> > descriptors when doing repeated operations on the same filesystem
> > object, I have noticed that there doesn't seem to be a way to set
> > mtime using a file descriptor.  Do we need a futimes() syscall?
> 
> There is a small problem with close(). It can update mtime as well.
> 

Presumably it shouldn't unless the file descriptor has been written
to since the last fsync().

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
