Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTFORLB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTFORLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:11:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262422AbTFORKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:10:53 -0400
Date: Sun, 15 Jun 2003 10:24:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
In-Reply-To: <m3of0zdzuz.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0306151021440.8088-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Jun 2003, Andi Kleen wrote:
>
> Because &arbitary_symbol_a - &arbitary_symbol_b is undefined in C and
> the amd64 gcc 3.2 choses to miscompile it (it results in a very big  
> number because it converts the 56/40 division to an inversed multiplication
> in a wrong way). I actually wrote a compiler bug report first, but the 
> compiler developers rightly pointed out that it is undefined.

They are not arbitrary symbols. They are symbols in the same data 
structure, set up by the linker script. Gcc doesn't know that, but the 
fact that gcc doesn't know doesn't mean that gcc should be lazy and 
doesn't really excuse buggy code.

The gcc developers you talked to are picking their legalistic noses, and 
it's sad that this isn't exactly the first time it has happened.

		Linus

