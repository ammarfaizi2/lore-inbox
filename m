Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271661AbSISQuN>; Thu, 19 Sep 2002 12:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271691AbSISQuN>; Thu, 19 Sep 2002 12:50:13 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20297 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271661AbSISQuM>; Thu, 19 Sep 2002 12:50:12 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209191655.g8JGtFd07783@devserv.devel.redhat.com>
Subject: Re: alan@redhat.com: Linux 2.4.20-pre7-ac2 - How's the IDE thing coming?
To: thunder7@xs4all.nl
Date: Thu, 19 Sep 2002 12:55:15 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <20020919163916.GA15635@middle.of.nowhere> from "Jurriaan" at Sep 19, 2002 06:39:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In terms of IDE reliability - how would you rate it? Is it 'safe' again,
> or is the IDE thing still shaping up?

Im cautiously trusting it. I use it for day to day work but I do have 
backups.

- PIO mode has performance problems, especially hdparm -u0
- There are some crash corner cases left on load/unloads somewhere
- pcmcia hangs on card eject
- PIO taskfile write causes lots of missed IRQ but doesnt seem to lose
  data
- Something isnt 100% with the serverworks "dont UDMA on OSB4" logic
- Simplex controllers we dont run in DMA mode yet (mostly shows up on ALi)

