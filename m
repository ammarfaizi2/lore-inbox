Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWB1Jiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWB1Jiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 04:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWB1Jiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 04:38:55 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:15793 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S932135AbWB1Jiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 04:38:54 -0500
Date: Tue, 28 Feb 2006 10:38:46 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       garloff@suse.de
Subject: Re: Linux v2.6.16-rc5 - regression
Message-ID: <20060228093846.GA24867@brainysmurf.cs.umu.se>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In -rc5 the printk timing numbers do not reset to [    0.000000] upon
boot. This worked in -rc4 and so I started bisecting and git came up
with:

commit 9827b781f20828e5ceb911b879f268f78fe90815
Author: Kurt Garloff <garloff@suse.de>
Date:   Mon Feb 20 18:27:51 2006 -0800

	[PATCH] OOM kill: children accounting

I can't see why that would break the timing information, but I'll just
assume that git was right, and tell you guys.

My system is:
Linux sap 2.6.16-rc4 #1 PREEMPT Mon Feb 20 13:34:18 CET 2006 i686
Intel(R) Pentium(R) 4 CPU 2.00GHz GenuineIntel GNU/Linux

Let me know if more information is needed.

	Peter Hagervall

-- 
Peter Hagervall......................email: hager@cs.umu.se
Department of Computing Science........tel: +46(0)90 786 7018
University of Umeå, SE-901 87 Umeå.....fax: +46(0)90 786 6126
