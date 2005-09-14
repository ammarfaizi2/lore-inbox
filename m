Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVING74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVING74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVING74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:59:56 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63426 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S965055AbVING7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:59:55 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.13/14 x86 Makefile - Pentiums penalized ?
Date: Wed, 14 Sep 2005 09:59:05 +0300
User-Agent: KMail/1.8.2
Cc: Chris White <chriswhite@gentoo.org>,
       Margit Schubert-While <margitsw@t-online.de>,
       linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de> <200509141414.08343.chriswhite@gentoo.org> <Pine.LNX.4.61.0509132345050.13185@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0509132345050.13185@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509140959.05902.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 September 2005 09:48, Zwane Mwaikambo wrote:
> On Wed, 14 Sep 2005, Chris White wrote:
> 
> > That's correct, gcc 3.4 started the -mtune flag.  Chances are if you really 
> > want the -mtune optimizations you're going to have to upgrade to gcc 3.4 or 
> > greater.
> > 
> > > This, of course, heavily penalizes P4's (the notorious inc/dec).
> > 
> > Are you referring to cpu cycle counts?  Is there certain code that causes the 
> > kernel to perform that unfavorably by a large scale?
> 
> It's documented as being suboptimal to use inc/dec due to it modifying all 
> of eflags resulting in dependency related stalls. add/sub only modifies 
> one bit of eflags so is more optimal. However there is a problem of 

?! add/sub doesn't modify "only one bit in eflags", it modifies all.
In fact, it's dec/inc which does not modify all bits.
It doesn't touch 'carry' bit (IIRC).

If inc/dec is slower on P4, it must be just another P4 quirk.

> increased code size with add/sub.
> 
> But i've never benchmarked all of this ;)

I don't even have one to test this.
--
vda
