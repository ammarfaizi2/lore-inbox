Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVHQTjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVHQTjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVHQTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:39:46 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:2719 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751203AbVHQTjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:39:46 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050817192707.GA27903@elte.hu>
References: <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
	 <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817192707.GA27903@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 15:39:20 -0400
Message-Id: <1124307560.5186.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 21:27 +0200, Ingo Molnar wrote:

> 
> Now that printk is in essence preemptible, there shouldnt be any 
> warnings from netconsole - if there are any then it should be possible 
> to fix them.
> 

Then I guess write_msg in netconsole.c needs to remove all the
local_irq_disable and enables.

-- Steve


