Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbULGWki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbULGWki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbULGWki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:40:38 -0500
Received: from mail1.slu.se ([130.238.96.11]:54151 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S261950AbULGWkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:40:33 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16822.12630.275389.575326@robur.slu.se>
Date: Tue, 7 Dec 2004 23:40:22 +0100
To: Karsten Desler <kdesler@soohrt.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, jamal <hadi@cyberus.ca>,
       Robert Olsson <Robert.Olsson@data.slu.se>, P@draigBrady.com
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
In-Reply-To: <20041207211035.GA20286@quickstop.soohrt.org>
References: <20041206205305.GA11970@soohrt.org>
	<20041207211035.GA20286@quickstop.soohrt.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Karsten Desler writes:

 > I totally forgot to mention: There are approximately 100k concurrent
 > flows.

 > >From dmesg:
 > IP: routing cache hash table of 16384 buckets, 128Kbytes

 You can take a looks at stats w. rtstat. Hash spinning and how many new 
 entires create and how many warm you hit. 


 > Maybe there is some contention on the rt_hash_table spinlocks?
 > Is the attached patch enough to increase the size?

 There is boot option for this now

   rhash_entries=  [KNL,NET]
                        Set number of hash buckets for route cache


						   --ro
