Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315264AbSEYTbe>; Sat, 25 May 2002 15:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSEYTbd>; Sat, 25 May 2002 15:31:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315264AbSEYTbd>; Sat, 25 May 2002 15:31:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: isofs unhide option:  troubles with Wine
Date: 25 May 2002 12:31:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <acooqj$2h2$1@cesium.transmeta.com>
In-Reply-To: <1022301029.2443.28.camel@jwhiteh> <Pine.LNX.4.44.0205251513280.10327-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0205251513280.10327-100000@sharra.ivimey.org>
By author:    Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
In newsgroup: linux.dev.kernel
> 
> AFAIK, Windows "hidden" files are supposed to behave much like Unix 'dot' 
> files (.login, etc), so IMO the kernel should not use the hidden bit at all. 
> Instead, it should be 'ls' et al that do this. Now, I guess this isn't 
> particularly practical without changing fileutils and many other things, so I 
> would suggest that the kernel is changed to pass on, if possible, but 
> basically ignore the 'hidden' bit.
> 

There really should be some kind of ioctl() or other syscall to
get/set the filesystem-specific attributes in cases like FAT (hidden,
system, archive) and ISO9660.  Trying to graft their meaning onto the
Unix system just doesn't make sense.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
