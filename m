Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285792AbRLHDnS>; Fri, 7 Dec 2001 22:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285794AbRLHDnI>; Fri, 7 Dec 2001 22:43:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43272 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285792AbRLHDmw>; Fri, 7 Dec 2001 22:42:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux/Pro  -- clusters
Date: 7 Dec 2001 19:42:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9us27n$plh$1@cesium.transmeta.com>
In-Reply-To: <UTC200112080150.BAA195557.aeb@cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200112080150.BAA195557.aeb@cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
> 
> Yes and no. If I am not mistaken there are three details:
> 
> (i) Linus prefers to separate block and character devices.
> I agree that that makes the code a bit cleaner, but dislike
> the code duplication: the interface to user space, the allocation,
> deallocation, registering is completely identical for the two.
> But apparently Linus does not mind a little bloat if that avoids
> an ugly cast in two or three places.
> 

I don't understand why you can't share this code.  The main reason for
having different types is so you don't mix them up -- they are
separante namespaces, and shouldn't be mixed up.  Having them be
different types makes the compiler enforce this.

If we were using C++ we could make a base class which contained the
common stuff.  As it is, perhaps a substructure would do it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
