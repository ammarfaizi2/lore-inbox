Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267269AbUBSOK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUBSOK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:10:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:26753 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267267AbUBSOKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:10:16 -0500
Date: Thu, 19 Feb 2004 09:12:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Joilnen Leite <pidhash@yahoo.com>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040219135212.34779.qmail@web12607.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0402190907470.30108@chaos>
References: <20040219135212.34779.qmail@web12607.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Joilnen Leite wrote:

> excuse me friends shcedule_timeout(1) is not a problem
> for spin_lock_irqsave ?
>
> drivers/scsi/ide-scsi.c:897
>
> spin_lock_irqsave(&ide_lock, flags);
> while (HWGROUP(drive)->handler) {
>        HWGROUP(drive)->handler = NULL;
>        schedule_timeout(1);
> }
>
> pub 1024D/5139533E Joilnen Batista Leite
> F565 BD0B 1A39 390D 827E 03E5 0CD4 0F20 5139 533E

What kernel version?  It is very bad. You can't sleep with
a spin-lock being held!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an Intel Pentium III machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


