Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278639AbRJST7T>; Fri, 19 Oct 2001 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278638AbRJST7J>; Fri, 19 Oct 2001 15:59:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21002 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278637AbRJST7B>; Fri, 19 Oct 2001 15:59:01 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Allocating more than 890MB in the kernel?
Date: 19 Oct 2001 12:59:20 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qq0mo$eun$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0110191204210.21846-100000@hill.cs.ucr.edu> <3BD08207.7090807@interactivesi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BD08207.7090807@interactivesi.com>
By author:    Timur Tabi <ttabi@interactivesi.com>
In newsgroup: linux.dev.kernel
> 
> > Isn't this solved by just recompiling the kernel with HIGHMEM support?
> 
> 
> I don't think so.  The Red Hat 7.1 kernel is compiled with "4GB" support, 
> which apparently is the same as HIGHMEM.  We see the 890MB kernel vmalloc 
> limit still.
> 

That's because you're running out of address space, not memory.
HIGHMEM doesn't do anything for the latter -- it can't.  You start
running into a lot of fundamental problems when your memory size gets
in the same (or higher) ballpark than your address space.

The best solution is go buy a 64-bit CPU.  There isn't much else you
can do about it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
