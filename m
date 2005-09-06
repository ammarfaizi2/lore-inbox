Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVIFVlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVIFVlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVIFVlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:41:19 -0400
Received: from ns1.suse.de ([195.135.220.2]:28053 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750841AbVIFVlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:41:18 -0400
Date: Tue, 6 Sep 2005 23:41:17 +0200 (CEST)
From: Michael Matz <matz@suse.de>
To: Terrence Miller <Terrence.Miller@Sun.COM>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Jakub Jelinek <jakub@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" ->
 "static inline"
In-Reply-To: <431E023E.3050301@Sun.COM>
Message-ID: <Pine.LNX.4.58.0509062332040.27439@wotan.suse.de>
References: <20050902203123.GT3657@stusta.de> <20050905184740.GF7403@devserv.devel.redhat.com>
 <431DD7BE.7060504@Sun.COM> <200509062223.50747.ak@suse.de> <431E023E.3050301@Sun.COM>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Sep 2005, Terrence Miller wrote:

> Andi Kleen wrote:
> > I don't think the functionality of having single copies in case 
> > an out of line version was needed was ever required by the Linux kernel.
> 
> But shouldn't the compiler that compiles Linux be C99 compliant?

As "extern inline" is a GNU extension I don't understand this remark.  
The notion of "function marked as inline but in fact wasn't inlined"
simply isn't covered by any C(++) standard, and isn't detectable by any
C99 compliant program.  Hence a compiler understanding this extension
could still be c99 compliant (right now I don't know if "extern inline"
would be a invalid c99, if it is, then see below).

Perhaps you meant "shouldn't linux be compilable by a compiler which only 
is C99 compliant".  If you meant this, then I would say no ;-)  Think 
e.g. inline asms, which a purely (in the sense of providing nothing more) 
C99 compiler couldn't provide.  OTOH gcc with the right options _is_ 
mostly c99 compliant, so in this sense linux is already compilable by a 
c99 compliant compiler.


Ciao,
Michael.
