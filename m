Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267223AbUHTXL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUHTXL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 19:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268793AbUHTXL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 19:11:57 -0400
Received: from czf-prosek6.supernetwork.cz ([81.31.22.46]:3968 "EHLO
	noodles.netw") by vger.kernel.org with ESMTP id S267223AbUHTXLz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 19:11:55 -0400
From: Jan Spitalnik <jan@spitalnik.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: 2.6.8.1 slews system clock
Date: Sat, 21 Aug 2004 01:11:53 +0200
User-Agent: KMail/1.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408201527.07126.jan@spitalnik.net> <Pine.LNX.4.53.0408201601200.12519@gockel.physik3.uni-rostock.de> <200408201702.01287.jan@spitalnik.net>
In-Reply-To: <200408201702.01287.jan@spitalnik.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408210111.53538.jan@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne pá 20. srpna 2004 17:02 Jan Spitalnik napsal(a):
> > Which was the last kernel that worked?
>
> 2.6.7 didn't exhibit this problem. I will test 2.6.8-rc's to find which one
> caused this regression.

Hi,

I've did further testing and I've found out that fortunately it's not a kernel 
problem (sorry for the buzz :-/ ). adjtimex was the culprit. 
adjtimexconfigure said that the CMOS clock is faster by 970secs a day to 
system clock. When I disabled adjtimex and rebooted, the system clock is now 
rock solid and doesn't slew. Now I wonder what's wrong with adjtimex or my 
system. I've tried on several other systems and the it was all the same.
Thanks,
  jan
-- 
Jan Spitalnik
jan@spitalnik.net

