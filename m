Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbREBLif>; Wed, 2 May 2001 07:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132822AbREBLiP>; Wed, 2 May 2001 07:38:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23055 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132765AbREBLiL>; Wed, 2 May 2001 07:38:11 -0400
Subject: Re: Patch: softdog and WDIOS_DISABLECARD
To: shane@cm.nu (Shane Wegner)
Date: Wed, 2 May 2001 12:41:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010502003359.A20841@cm.nu> from "Shane Wegner" at May 02, 2001 12:33:59 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uv17-0003SW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have found a potential problem with the current
> implementation of the software watchdog.  I have
> CONFIG_WATCHDOG_NOWAYOUT set for a reliable watchdog. 
> However, there are instances where I want to explicitly
> shut it down.  The problem with disabling

It is intentional you cannot shut it down. The whole point of that mode
of operation is that you can make definitive statements about your watchdogs.

You can swap the watchdog process with any simple program that keeps it ticking
while you do other work, then swap back.

