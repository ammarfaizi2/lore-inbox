Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbQKRBu2>; Fri, 17 Nov 2000 20:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbQKRBuS>; Fri, 17 Nov 2000 20:50:18 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:40839 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S130870AbQKRBuK>;
	Fri, 17 Nov 2000 20:50:10 -0500
Date: Fri, 17 Nov 2000 20:20:09 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VGA PCI IO port reservations
Message-ID: <20001117202009.B2472@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200011172002.UAA01918@raistlin.arm.linux.org.uk> <Pine.LNX.3.95.1001117150349.23529A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1001117150349.23529A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Nov 17, 2000 at 03:27:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 03:27:28PM -0500, Richard B. Johnson wrote:
> Then, you read the port as a WORD (16 bits). If nothing responds,
> you get the value of 0xffff. If somebody is responding, you will
> read something if it's enabled for writes by devices (reads by the CPU).

What guarantees you that:
1- No device will respond 0xffff for an address it decodes
2- No device will crap up on you simply because you've read one
particular address

If any of these if true for any device out there (I think I have one
in my computer that does the 1/ part in some cases), your code is
unsafe.

  OG.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
