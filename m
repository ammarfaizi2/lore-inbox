Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbTHCTiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbTHCTiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:38:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39081 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267517AbTHCTip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:38:45 -0400
Date: Sun, 3 Aug 2003 21:37:08 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: Re: sleeping in dev->tx_timeout?
Message-ID: <20030803193708.GA13992@oasis.frogfoot.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux Kernel Discussions <linux-kernel@vger.kernel.org>
References: <20030803183707.GA13728@oasis.frogfoot.net> <Pine.LNX.4.53.0308031505390.3473@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308031505390.3473@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 21:34:59 up 28 days, 21:41, 8 users, load average: 0.01, 0.05, 0.01
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zwane                                         >@2003.08.03_21:10:56_+0200

> > Is it safe to sleep in tx_timeout (in the networking code), i.e. to call
> > schedule_timeout and friends from that routine?
> 
> No it's called from softirq context and with the dev->xmit_lock held in 
> places.

That's what I thought. How are you supposed to wait for long periods from
tx_timeout? My problem is that I have a chip reset which takes around 10ms
(i.e. too long to use mdelay())

-- 

Regards
 Abraham

No problem is insoluble in all conceivable circumstances.

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

