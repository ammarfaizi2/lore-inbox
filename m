Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272108AbVBEOrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272108AbVBEOrw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 09:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbVBEOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 09:47:52 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:47532 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S272108AbVBEOrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 09:47:46 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Date: Sat, 5 Feb 2005 15:48:26 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
References: <20050204103350.241a907a.akpm@osdl.org> <200502051411.16194.rjw@sisk.pl> <20050205143511.GA28656@elte.hu>
In-Reply-To: <20050205143511.GA28656@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051548.26729.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 5 of February 2005 15:35, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > It looks like softlockup is not happy with suspend/resume:
> 
> Does it happen while writing out state to disk?

No, it occurs during resume, right after the image has been restored (sorry,
I should have said this before).

> I've attached a patch for touch_softlockup_watchdog() below - but i think
> what we really need is another mechanism. I'm wondering what the primary
> reason for the lockup-detection is - did swsuspend stop the the softlockup
> threads? 

If my understanding is correct, the time between suspend (ie the creation of
the image) and resume (ie the resotration of the image) is considered as spent
in the kernel, so it triggers softlockup as soon as its threads are woken up (is
that correct, Pavel?).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
