Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272882AbTHKREX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272838AbTHKRCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:02:03 -0400
Received: from mailb.telia.com ([194.22.194.6]:28379 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S272818AbTHKQ6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:58:49 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  ...
Date: Mon, 11 Aug 2003 19:01:13 +0200
User-Agent: KMail/1.5.9
Cc: Davide Libenzi <davidel@xmailserver.org>
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <200308100405.52858.roger.larsson@skelleftea.mail.telia.com> <3F35DB73.8090201@cyberone.com.au>
In-Reply-To: <3F35DB73.8090201@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308111901.13131.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 August 2003 07.43, Nick Piggin wrote:
> Roger Larsson wrote:
> >*	SCHED_FIFO requests from non root should also be treated as SCHED_SOFTRR
>
> I hope computers don't one day become so fast that SCHED_SOFTRR is
> required for skipless mp3 decoding, but if they do, then I think
> SCHED_SOFTRR should drop its weird polymorphing semantics ;)

After some tinking...

Neither SCHED_FIFO nor SCHED_RR should automatically be promoted to 
SCHED_SOFTRR in the kernel.

* If a process knows about SCHED_SOFTRR it should use that.
  (example: arts should use SCHED_SOFTRR not SCHED_FIFO)
  Problem: what to do when compiling for UN*Xes that does not have SOFTRR.
  [Is there any other UN*X that have something resembling of this? What do
   they call it?]

* Cases where the code has not been modified should be handled by a wrapper
  (library). setscheduler is a weak symbol isn't it?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
