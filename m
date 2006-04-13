Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWDMO7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWDMO7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWDMO7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:59:18 -0400
Received: from ns1.idleaire.net ([65.220.16.2]:51149 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S1750833AbWDMO7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:59:16 -0400
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
From: Dave Dillow <dave@thedillows.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <200604130904.57054.vda@ilport.com.ua>
References: <200604071628.30486.vda@ilport.com.ua>
	 <200604121155.55561.vda@ilport.com.ua>
	 <1144862325.18319.32.camel@dillow.idleaire.com>
	 <200604130904.57054.vda@ilport.com.ua>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 10:59:08 -0400
Message-Id: <1144940349.29160.13.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2006 14:58:39.0146 (UTC) FILETIME=[BF5C80A0:01C65F0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 09:04 +0300, Denis Vlasenko wrote:
> On Wednesday 12 April 2006 20:18, Dave Dillow wrote:
> > > > or loaded. And even if it saves 200 bytes in one 
> > > > module, unless that module text was already less than 200 bytes into a
> > > > page, you've saved no memory -- a 4300 byte module takes 2 pages on x86,
> > > > as does a 4100 byte module.
> > > 
> > > Sometimes, those 200 bytes can bring module size just under 4096.
> > > Thus on the average, on many modules you get the same size savings
> > > as on built-in code. (Not that we have THAT many network modules...)
> > 
> > You're making a bogus leap from "sometimes" to "average".
> 
> It's not bogus. See below.

My bad, I used a different notion of "average". You're using a
mathematical definition, and are of course correct in that case.

But to get your average, you have to either build all modules in, or
load every module. I'm saying the "average" user won't do that.

> IOW: currently most of VLAN code is already in kernel.

No, I'm saying most of the code is in 8021q.ko. The exceptions are the
big inlines you targeted, and I agree with moving them out-of-line.

-- 
Dave Dillow <dave@thedillows.org>

