Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752123AbWJZJHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbWJZJHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbWJZJHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:07:05 -0400
Received: from adsl-ull-235-236.42-151.net24.it ([151.42.236.235]:7719 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S1752123AbWJZJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:07:02 -0400
Message-ID: <454079F5.3040204@abinetworks.biz>
Date: Thu, 26 Oct 2006 11:03:49 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	<1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org>
In-Reply-To: <20061025205923.828c620d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i apologize for being bothering you twice in three days but i was 
wondering whether someone has found reason why ndiswrapper does not load 
on 2.6.19-rc2-mm2.

NOTE: it seems to be related to tainting

I try to resume a bit:

__create_workqueue         undefined symbol
queue_work                       undefined symbol

After patching modules.c to remove tainting of ndiswrapper i got to load 
it without problems but it doesnt seem a modules.c problem (those 
symbols are EXPORT_GPL since at least 2.6.18), modules.c and workqueue.c 
are as of 2.6.16 kernel.

Is there any new ?

If i can tell my user opinion about tainting is that it s...cks in 
general, dont know any case in which it fits something, i mean in life 
not just linux kernel.
One who uses ndiswrapper doest it at his own risk, a developer or 
debugger can manage...
And the blacklist hardcoded in modules.c, as someone used to say couple 
days ago, seems really hard to carry on !

THanks to anyone who will find time to show me the light,

Gianluca
