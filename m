Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310219AbSCBA34>; Fri, 1 Mar 2002 19:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310221AbSCBA3q>; Fri, 1 Mar 2002 19:29:46 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:10665 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S310219AbSCBA3i>; Fri, 1 Mar 2002 19:29:38 -0500
Message-Id: <5.1.0.14.2.20020301161728.0d6b8580@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Mar 2002 16:28:52 -0800
To: "David S. Miller" <davem@redhat.com>, rml@tech9.net
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] spinlock not locked when unlocking in
  atm_dev_register
Cc: fisaksen@bewan.com, mitch@sfgoth.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020301.143809.91757055.davem@redhat.com>
In-Reply-To: <1015022109.11499.47.camel@phantasy>
 <20020301163936.7FA725F963@postfix2-2.free.fr>
 <5.1.0.14.2.20020301143010.0d552be8@mail1.qualcomm.com>
 <1015022109.11499.47.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    > btw ATM locking seems to be messed up. Is anybody working on that ?
>
>    Not that I know of.  Volunteer? :)
>
>I consider it pretty much unmaintained.  Feel free to take it up :)
I'd rather work on my Bluetooth stuff for now :)

The reason I looked at the ATM stuff is that I got this DSL thing from 
PacBell that
came with Alcatel ADSL USB modem which talks to the ATM layer. The guy who
wrote that USB driver had a comment that it doesn't work on SMP for 
_unknown reason_ :)
Quick glance at the ATM code, revealed that one of reasons is messed up 
looking.
So I fixed device registration and now it works. But ATM locking in general 
has to be fixed.

Max

