Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVDFTaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVDFTaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVDFTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:30:00 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:26043 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262297AbVDFT36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:29:58 -0400
Date: Wed, 6 Apr 2005 21:30:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Renate Meijer <kleuske@xs4all.nl>, stable@kernel.org,
       Greg KH <gregkh@suse.de>, jdike@karaya.com,
       linux-kernel@vger.kernel.org
Subject: Re: [08/08] uml: va_copy fix
Message-ID: <20050406193008.GC17413@wohnheim.fh-wedel.de>
References: <20050405164539.GA17299@kroah.com> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <200504062109.51344.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504062109.51344.blaisorblade@yahoo.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 April 2005 21:09:50 +0200, Blaisorblade wrote:
>
> I'm reattaching the patch, so that you can look at the changelog (I'm also 
> resending it as a separate email so that it is reviewed and possibly merged). 
> Basically this is an error in GCC 2 and not in GCC 3:
> 
> int [] list = {
>  [0] = 1,
>  [0] = 1
> }
> (I've not tested the above itself, but this should be a stripped down version 
> of one of the bugs fixed in the patch).
> 
> That sort of code in the UML syscall table is not the safer one - in fact, 
> apart this patch for the stable tree, I'm refactoring the UML syscall table 
> completely (for 2.6.12 / 2.6.13).
> 
> Btw: I've not investigated which one of the two behaviours is the buggy one - 
> if you know, maybe you or I can report it.

Your code is at best redundant.  And I'd bet beer that it is not what
its author intended to write.  So the bug is in GCC 3, imo.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown
