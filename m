Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274939AbTGaXVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274942AbTGaXVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:21:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35322 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S274939AbTGaXTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:19:25 -0400
Subject: Re: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
From: Robert Love <rml@tech9.net>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1059692337.931.325.camel@localhost>
References: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
	 <200308010045.08178.roger.larsson@skelleftea.mail.telia.com>
	 <1059692337.931.325.camel@localhost>
Content-Type: text/plain
Message-Id: <1059693971.786.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 16:26:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 15:58, Robert Love wrote:
> On Thu, 2003-07-31 at 15:45, Roger Larsson wrote:
> 
> > This smells preemptive kernel, correct?
> 
> Doesn't look like anything specific to kernel preemption to me.

Oh I really misgrok'ed this.

Yah, kernel preemption catches the reschedule off of the interrupt and
thus this is never true (always zero). The "never zero" thing confused
me, sorry.

Moving the stuff into the while loop is one option.

	Robert Love


