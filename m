Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276461AbRJCQXV>; Wed, 3 Oct 2001 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276469AbRJCQXC>; Wed, 3 Oct 2001 12:23:02 -0400
Received: from colorfullife.com ([216.156.138.34]:37380 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S276461AbRJCQW5>;
	Wed, 3 Oct 2001 12:22:57 -0400
Message-ID: <001e01c14c27$bc542070$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "jamal" <hadi@cyberus.ca>
Subject: Re: [patch] auto-limiting IRQ load take #2, irq-rewrite-2.4.11-F4
Date: Wed, 3 Oct 2001 18:23:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Ingo Molnar wrote:
>
> the attached patch contains a cleaned up version of IRQ
> auto-mitigation.
>

What's the purpose of the patch?
Should it enable itself under load, or is it an emergency switch if a
broken driver (or broken hardware) causes an IRQ storm that makes the
computer unusable?

As an emergency switch it's a good idea.
But it should never enable itself unless the box is nearly dead, and it
can't replace NAPI and interrupt mitigation.

> (i'd like to stress the point again that the goal of this approach
> is *not* to be nice. This is an airbag mechanizm, it can and
> will hurt performance. But my box does not lock up
> anymore.)
>
Ok, then I like the patch.

--
    Manfred



