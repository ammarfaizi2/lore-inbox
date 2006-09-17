Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWIQU5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWIQU5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 16:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWIQU5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 16:57:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7862 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965066AbWIQU5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 16:57:25 -0400
Subject: Re: Crash on boot after abrupt shutdown
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Chew <keith.chew@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20f65d530609161930m2311974esfeaa2fbc2592e49f@mail.gmail.com>
References: <20f65d530609161930m2311974esfeaa2fbc2592e49f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 17 Sep 2006 22:21:17 +0100
Message-Id: <1158528078.6069.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-17 am 14:30 +1200, ysgrifennodd Keith Chew:
> It has been doing very well, except for this scenario. The wireless
> interface wlan0 is busy communicating, and the power is disconnected
> abruptedly. In the next boot, we get a kernel panic when the wlan
> interface is initialised.
> 
> We want to know if this is due to linux's journaling file system 

Very unlikely but you don't provide enough information to even guess.

I've seen similar behaviours before and they usually indicate a bug in
the driver that crashed. Eg the setup code for a network card not being
able to cope if the network card is in a particular state but does
enough that next boot it works.

You need to work back from your wireless driver panic to the root cause
of that panic and then back from there.


