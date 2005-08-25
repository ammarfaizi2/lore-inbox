Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVHYQQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVHYQQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVHYQQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:16:11 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42904 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932214AbVHYQQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:16:11 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20050825063539.GB27291@elte.hu>
References: <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124749192.17515.16.camel@dhcp153.mvista.com>
	 <1124756775.5350.14.camel@localhost.localdomain>
	 <1124758291.9158.17.camel@dhcp153.mvista.com>
	 <1124760725.5350.47.camel@localhost.localdomain>
	 <1124768282.5350.69.camel@localhost.localdomain>
	 <1124908080.5604.22.camel@localhost.localdomain>
	 <1124917003.5711.8.camel@localhost.localdomain>
	 <1124932391.5527.15.camel@localhost.localdomain>
	 <20050825063539.GB27291@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 25 Aug 2005 12:15:54 -0400
Message-Id: <1124986554.5148.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 08:35 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Well, after turning off hrtimers, I keep getting one bug. A possible 
> > soft lockup with the ext3 code. But this didn't seem to be caused by 
> > the changes I made. So just to be sure, I ran my test on the vanilla 
> > 2.6.13-rc6-rt11 and it gave the same bug too.  So, it looks like my 
> > changes are now at par with what is out there with the rt11 release. 
> > They both give the same bug! ;-)
> 
> does the system truly lock up, or is this some transitional condition?  
> In any case, i agree that this should be debugged independently of the 
> pi_lock patch.

Hmm, I forgot that you took out the bit_spin_lock fixes.  I think this
may be caused by them.  I haven't look further into it yet. 

Oh, and I'm sending you this on your latest patch with my pi_lock patch
applied. (no debugging turned on either and this is an SMP machine).

-- Steve

