Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSB1XxR>; Thu, 28 Feb 2002 18:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSB1XvL>; Thu, 28 Feb 2002 18:51:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37637 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310235AbSB1Xsh>; Thu, 28 Feb 2002 18:48:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: question about running program from a RAM disk
Date: 28 Feb 2002 15:48:26 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a5mfka$jgl$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1020228170705.2670A-100000@chaos.analogic.com> <01bc01c1c0a6$a3c315e0$bb3147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <01bc01c1c0a6$a3c315e0$bb3147ab@amer.cisco.com>
By author:    "Hua Zhong" <hzhong@cisco.com>
In newsgroup: linux.dev.kernel
>
> In the final system we are going to turn off swap. I had dreamed that Linux
> could directly use the page frame on the RAM disk instead of doing another
> copy :-)
> 

However, the reply you got was completely irrelevant; he didn't answer
your question at all (even though he probably thought.)

The answer to your question is that a ramdisk lives directly in the
block cache and does not have to be copied.

You may want to consider migrating to a ramfs or tmpfs, which lives
directly in the *page* cache and therefore reduces overhead further.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
