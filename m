Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVHYGfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVHYGfE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbVHYGfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:35:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:948 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751541AbVHYGfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:35:01 -0400
Date: Thu, 25 Aug 2005 08:35:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
Message-ID: <20050825063539.GB27291@elte.hu>
References: <1124739657.5809.6.camel@localhost.localdomain> <1124739895.5809.11.camel@localhost.localdomain> <1124749192.17515.16.camel@dhcp153.mvista.com> <1124756775.5350.14.camel@localhost.localdomain> <1124758291.9158.17.camel@dhcp153.mvista.com> <1124760725.5350.47.camel@localhost.localdomain> <1124768282.5350.69.camel@localhost.localdomain> <1124908080.5604.22.camel@localhost.localdomain> <1124917003.5711.8.camel@localhost.localdomain> <1124932391.5527.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124932391.5527.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Well, after turning off hrtimers, I keep getting one bug. A possible 
> soft lockup with the ext3 code. But this didn't seem to be caused by 
> the changes I made. So just to be sure, I ran my test on the vanilla 
> 2.6.13-rc6-rt11 and it gave the same bug too.  So, it looks like my 
> changes are now at par with what is out there with the rt11 release. 
> They both give the same bug! ;-)

does the system truly lock up, or is this some transitional condition?  
In any case, i agree that this should be debugged independently of the 
pi_lock patch.

	Ingo
