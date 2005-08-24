Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVHXVEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVHXVEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVHXVEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:04:42 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:45805
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932215AbVHXVEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:04:41 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1124917003.5711.8.camel@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124749192.17515.16.camel@dhcp153.mvista.com>
	 <1124756775.5350.14.camel@localhost.localdomain>
	 <1124758291.9158.17.camel@dhcp153.mvista.com>
	 <1124760725.5350.47.camel@localhost.localdomain>
	 <1124768282.5350.69.camel@localhost.localdomain>
	 <1124908080.5604.22.camel@localhost.localdomain>
	 <1124917003.5711.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 24 Aug 2005 21:05:25 +0000
Message-Id: <1124917526.20120.72.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 16:56 -0400, Steven Rostedt wrote:

> Also Thomas,
> 
> I'm still triggering that "huh?" statement in pi_setprio, and it is
> always with the softirq-hrtimer thread.  It likes to change its
> priorities, but there's a time when p->normal_prio != normal_prio(p).
> And this is what's giving me a headache.

Yes, the normal_prio() check detects this. I have a look into this.

tglx


