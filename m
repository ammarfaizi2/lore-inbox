Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288566AbSAIXiF>; Wed, 9 Jan 2002 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289082AbSAIXhr>; Wed, 9 Jan 2002 18:37:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52490 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288566AbSAIXhY>; Wed, 9 Jan 2002 18:37:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Moving zlib so that others may use it
Date: 9 Jan 2002 15:36:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1ik6l$hfm$1@cesium.transmeta.com>
In-Reply-To: <3C3CD304.9070704@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C3CD304.9070704@acm.org>
By author:    Corey Minyard <minyard@acm.org>
In newsgroup: linux.dev.kernel
>
> I'm working on a function that uses zlib in the kernel, and I know of 
> other places zlib is used (ppp_deflate, jffs2, mcore).  I would expect 
> more users to come along.
> 

CAREFUL.  First of all, don't mix up the deflate and inflate
functions, second of all, make sure you get the memory management
right.  It's not trivial to do the latter, since the default zlib
memory management is unusable for at least some users in kernelspace.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
