Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSAXT31>; Thu, 24 Jan 2002 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSAXT3I>; Thu, 24 Jan 2002 14:29:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25104 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288862AbSAXT2z>; Thu, 24 Jan 2002 14:28:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFC: booleans and the kernel
Date: 24 Jan 2002 11:28:46 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2pn9e$mt5$1@cesium.transmeta.com>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C5047A2.1AB65595@mandrakesoft.com>
By author:    Jeff Garzik <jgarzik@mandrakesoft.com>
In newsgroup: linux.dev.kernel
>
> A small issue... 
> 
> C99 introduced _Bool as a builtin type.  The gcc patch for it went into
> cvs around Dec 2000.  Any objections to propagating this type and usage
> of 'true' and 'false' around the kernel?
> 
> Where variables are truly boolean use of a bool type makes the
> intentions of the code more clear.  And it also gives the compiler a
> slightly better chance to optimize code [I suspect].
> 
> Actually I prefer 'bool' to '_Bool', if this becomes a kernel standard.
> 

Noone is actually meant to use _Bool, except perhaps in header files.

#include <stdbool.h>

... then use "bool", "true", "false".

This is fine with me as long our version of stdbool.h contain the
appropriate ifdefs.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
