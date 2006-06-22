Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWFVRKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWFVRKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWFVRKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:10:47 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:21931 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751826AbWFVRKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:10:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Cjwh7doi8G4/WG+BeAAi5vISddEO8v1Vo6PvE8tB9l9uyAgI2UdAWb507FEP3appYxR1A+6ay5yQZeTHwUH8BoNaNP17dOfA5jxFOJZf/3buKkPqEvKNy9cQBW403qXiyLv4fMLCCbM8NLUR+oNmjWVmw9ThlTByd8OlF+PB0gU=  ;
Message-ID: <20060622171045.28489.qmail@web33314.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 10:10:45 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Dropping Packets in 2.6.17
To: =?ISO-8859-1?Q?=20=22P=E1draig=22?= Brady <P@draigBrady.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <449AB69C.6090207@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Pádraig Brady <P@draigBrady.com> wrote:

> Danial Thom wrote:
> > 
> > --- Pádraig Brady <P@draigBrady.com> wrote:
> > 
> >>For reference with 2.4.20 on a dual 3.4GHz
> xeon
> >>and 2 x e1000 cards, I was able to capture,
> >>classify and do statistical calculations
> >>on 625Kpps per interface (1.3 million pps).
> > 
> > Unfortunately I can do that much with FreeBSD
> 4.x
> > with 1 2.0Ghz opteron, so its not a very
> > compelling case to have to spend twice as
> much on
> > hardware to use LINUX. However 2.4 seemed
> much
> > better than 2.6 in this regard. 2.6 wants to
> drop
> > a lot more packets. The goal of using 2.6 is
> to
> > utilize DP better, but it obviously has to
> > perform better than a UP Freebsd box.
> 
> NC.
> 
> > What ITR setting are using for the e1000
> driver?
> 
> I didn't use ITR, I used NAPI.
> 

If thats the case then your "system" would have
the same problem that I'm encountering, since
polling results in buckets of packets being
dropped with heavy userland activity.

Since you can control exactly how many interrupts
are generated and how often, there should be no
advantage to polling,  unless LINUX interrupt
processing is badly broken, which seems like a
strong possibility.

This should work quite naturally without having
to use kludges like polling, enormous receive
rings or memory cheating. 

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
