Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288267AbSACROT>; Thu, 3 Jan 2002 12:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288270AbSACROJ>; Thu, 3 Jan 2002 12:14:09 -0500
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:45327 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288269AbSACROE>; Thu, 3 Jan 2002 12:14:04 -0500
Date: Thu, 3 Jan 2002 18:13:51 +0100
From: jtv <jtv@xs4all.nl>
To: Edgar Toernig <froese@gmx.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103181351.C20936@xs4all.nl>
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu> <25193.1010018130@redhat.com> <3C347CC3.E7154C36@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C347CC3.E7154C36@gmx.de>; from froese@gmx.de on Thu, Jan 03, 2002 at 04:46:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 04:46:11PM +0100, Edgar Toernig wrote:
> 
> The behaviour is undefined by the C standard.  But the mentioned
> pointer arithmetic is defined in the environment where it has been
> used.  GCC tries to optimize undefined C-standard behaviour.  And
> IMHO that's the point.  It may optimize defined behaviour and should
> not touch things undefined by the standard.

Ah, if only things were that easy!  The whole reason the rules are as they
are in C is that it is not generally decidable whether or not the code
falls within those rules.  Removing the assumptions we're talking about 
from the rules would make the ability to optimize code an exception instead 
of the rule.


Jeroen

