Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269857AbRHDVtj>; Sat, 4 Aug 2001 17:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269861AbRHDVt3>; Sat, 4 Aug 2001 17:49:29 -0400
Received: from femail39.sdc1.sfba.home.com ([24.254.60.33]:51076 "EHLO
	femail39.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269857AbRHDVtR>; Sat, 4 Aug 2001 17:49:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: linux-kernel@vger.kernel.org
Subject: Possibly unfreezable system?
Date: Sat, 4 Aug 2001 14:52:14 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01080414521403.02694@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm going to get my ass handed to me for this one, I just know it, but I 
have to try.)

I'm not a coder, I can't impliment this, I don't even know for sure if it 
IS possible to impliment without a complete rewrite of the kernel.
This is also not something that would likely be added to 2.4, it'd 
probably be a 2.5 thing.

Note that I intend for the behavior below to be CONFIGURABLE, NOT the 
default behavior of the kernel, and that the exact behavior be (somewhat) 
configurable without diving into the code.

I've lately seen many complaints regarding the inability to even access a 
system that something (such as kswapd) is going crazy on.
The solution, to me, seems simple, have the kernel reserve some extra RAM 
at boot (a few megs), and dictate that it get at least X amount of 
processor time, consistantly, to allow for the following:
An alt-sysrq key that switches to a certain virtual console, kills 
whatever might already be running there, and allow a person to log in in 
order to kill whatever is causing the system to freeze, run out of 
memory, etc. The program(s) running here would run in that extra RAM the 
kernel reserved at boot.
This obviously degrades performance somewhat, but if properly 
implimented, the pros could outweigh the cons on even the most 
resource-sensitive systems.

Again, I mean for this to be CONFIGURABLE, and NOT the default behavior.
And please, don't flame me, none of this may be doable, if so, I 
apologize for wasting everyone's time.
