Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVGCO1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVGCO1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 10:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVGCO1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 10:27:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7583 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261449AbVGCO1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 10:27:43 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] all-arch delay functions take 2
Date: Sun, 3 Jul 2005 17:27:27 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200507031650.13770.vda@ilport.com.ua> <9a8748490507030714d2a1b45@mail.gmail.com>
In-Reply-To: <9a8748490507030714d2a1b45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507031727.27445.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 July 2005 17:14, Jesper Juhl wrote:
> On 7/3/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> > Hi folks,
> > 
> > This patch makes mdelay/udelay/ndelay calls as small
> > as possible (just a function call), uses macros which
> > do compile-time checks on delay duration if parameter
> > is a constant, otherwise check is done at run time
> > to prevent udelay(-1) disasters.
> > 
> [snip]
> 
> > 
> > -#define ndelay(n)      udelay((n) * 5)
> > +//BOGUS! #define ndelay(n)     udelay((n) * 5)
> > 
> If it's bogus, why not just remove it instead of leaving it in as a
> comment (and a C++ style comment at that) ?

I wanted to draw attention of someone who knows what's going on.
Can be removed altogether instead.
 
> [snip]
> > +//extern struct timer_opts* timer;
> 
> Why add this at all if you are just going to comment it out anyway?

Sorry, this is a leftover meant to be deleted.
--
vda

