Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRDFA7J>; Thu, 5 Apr 2001 20:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRDFA7A>; Thu, 5 Apr 2001 20:59:00 -0400
Received: from andrew.Triumf.CA ([142.90.106.59]:60172 "EHLO andrew.triumf.ca")
	by vger.kernel.org with ESMTP id <S130507AbRDFA6l>;
	Thu, 5 Apr 2001 20:58:41 -0400
Date: Thu, 5 Apr 2001 17:57:48 -0700 (PDT)
From: Andrew Daviel <andrew@andrew.triumf.ca>
Reply-To: Andrew Daviel <advax@triumf.ca>
To: <linux-kernel@vger.kernel.org>
Subject: syslog insmod please!
Message-ID: <Pine.LNX.4.30.0104051751410.20174-100000@andrew.triumf.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a good reason why insmod should not call syslog() to log
any module that gets installed ? I know things like bttv get very verbose
in the module itself, and I tried patching insmod to log the first
argument and it seemed to work for me.

I was looking at the knark LKM rootkit and wondering how to detect this
beast. Typically it seemss one does "insmod knark.o" then maybe "insmod
modhide.o" to prevent it showing in /proc/modules (seems to remove the
last loaded module from a linked list if I read it aright).  Adding a
syslog call to the insmod binary might get this logged on a remote host
with a bit of luck.

On a more esoteric note, how would one detect that this kind of module
has been installed (modhide) ? I presume one could dive into /dev/mem or
load another module to go look, but I've no idea where to start.

-- 
Andrew Daviel, TRIUMF, Canada
Tel. +1 (604) 222-7376
security@triumf.ca

