Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVK1XIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVK1XIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVK1XIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:08:48 -0500
Received: from terminus.zytor.com ([192.83.249.54]:25526 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750922AbVK1XIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:08:47 -0500
Message-ID: <438B8DC6.8070006@zytor.com>
Date: Mon, 28 Nov 2005 15:07:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <438B600C.1050604@tmr.com> <438B827A.2090609@wolfmountaingroup.com> <438B8BF8.4020604@vmware.com>
In-Reply-To: <438B8BF8.4020604@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> 
> You need a way to type the lock semantics by memory region, and a 
> working hardware solution can not perform as well as a careful software 
> solution.  As was pointed out earlier, you can't use memory type 
> attributes to infer lock semantics, you must assume them in the decoder 
> or implement complex deadlock detection and recovery in silicon.
> 

Sure you can.  You just have to be prepared to take a microop exception 
if you speculate incorrectly.

	-hpa
