Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVGWQo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVGWQo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGWQo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:44:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57570 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261827AbVGWQoX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:44:23 -0400
Date: Sat, 23 Jul 2005 09:44:21 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050723164421.GE4951@us.ibm.com>
References: <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain> <Pine.LNX.4.61.0507231456000.3728@scrub.home> <1122124324.3582.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231524430.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507231524430.3743@scrub.home>
X-Operating-System: Linux 2.6.13-rc3-mm1 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [15:29:42 +0200], Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Arjan van de Ven wrote:
> 
> > jiffies/HZ is the more powerful API. The msec one which also sets
> > current to (un)interruptible is the simplified wrapper on top.
> 
> So why do you want to hide it? Make the jiffies based API the primary one 
> and add some convenience functions, where we BTW could convert already 
> constants at compile time.

We are not hiding anything; we are providing an alternative for those
users that would like to request wall-time (human-time) units -- those
users do not (or should not, if nothing else) expect any kind of
precision from the sleeping path.

Thanks,
Nish
