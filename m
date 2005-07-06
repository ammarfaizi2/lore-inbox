Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVGFVGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVGFVGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVGFVCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:02:13 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:18843 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262566AbVGFVAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:00:08 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 22:00:08 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507062047.26855.s0348365@sms.ed.ac.uk> <20050706204429.GA1159@elte.hu>
In-Reply-To: <20050706204429.GA1159@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507062200.08924.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 21:44, Ingo Molnar wrote:
[snip]
>
> the ACPI-idle bug's primary effects were the missed wakeups, but they
> should not cause lockups, because timer interrupts should always occur
> and should eventually 'fix up' such missed wakeups.
>
> but there's another side-effect of the ACPI-idle bug: the ACPI code was
> running with interrupts enabled and maybe the hardware locks up if
> interrupted in the wrong moment. ACPI sleeps are sensitive things and
> closely related to other IRQ hardware, which we all program with
> interrupts disabled. So i'd not be surprised if the lockups were caused
> by the ACPI-idle bug.
>
> 	Ingo

Okay, well an hour later and still no lockups, so you're probably right.

This is a completely unrelated question, but now we've got everything under 
control.. how do I make "quiet" actually do something on the RT patchset?

Currently I flag it on the kernel cmdline, but I still get everything spewed 
to my primary VT.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
