Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319789AbSIMVIx>; Fri, 13 Sep 2002 17:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319792AbSIMVIx>; Fri, 13 Sep 2002 17:08:53 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:29414 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319789AbSIMVIw>; Fri, 13 Sep 2002 17:08:52 -0400
Date: Fri, 13 Sep 2002 14:13:34 -0700
From: "Jim Sibley" <jimsibley@earthlink.net>
To: wookie@osdl.org
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org,
       thunder@lightweight.ods.org
Reply-To: jimsibley@earthlink.net
Subject: RE: Killing/balancing processes when overcommited
Message-ID: <Springmail.0994.1031951614.0.51325400@webmail.pas.earthlink.net>
X-Originating-IP: 32.97.110.142
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim wrote:
>  There is another solution.  And that is never >allocate memory unless
>you have swap space.  Yes, the issue is that you >need to have lots of
>disk allocated to swap but on a big machine you >will have that space.

How do you predict if a program is going to ask for more memory? Maybe it only
needs additional memory for a short time and is a good citizen and gives it
back?

How much disk needs to be allocated for swap? In 32 bit, each logged in user
is limited to 2 GB, so do we need 2 GB for each logged on user? 250 users, 500
GB of disk?

In a 64 bit system, how much swap would you reserve?

Actually, another OS took this approach in the early 70's and this was quickly
junked when they found out how much disk they really had to keep in reserve
for paging.

>  This way the offending process that asks for >more memory will be
>the one that gets killed.  Even if the 1st couple >of ones aren't the
>misbehaving process eventually it will ask for >more memory and suffer
>process execution.  

It may not be the "offending process" that is asking for more memory. How do
you judge "offending?"






