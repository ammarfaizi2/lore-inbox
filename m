Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVC2JZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVC2JZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVC2JZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:25:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:49117 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262250AbVC2JZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:25:31 -0500
Date: Tue, 29 Mar 2005 11:25:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Chris Friesen <cfriesen@nortel.com>,
       krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure time accurately.
In-Reply-To: <Pine.LNX.4.62.0503291107000.3229@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.61.0503291123220.3370@yvahk01.tjqt.qr>
References: <424779F3.5000306@globaledgesoft.com> <4248E282.1000105@nortel.com>
 <Pine.LNX.4.62.0503291107000.3229@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>In some cases you can simply count jiffies - depending on how accurate you 
>need to time things I'd say that often something like this is adequate :

These "some cases" exclude this one:
If interrupts are disabled, a jiffy might be missed. Take care.

If you are on UP and want to measure within
- a tick [when using preempt]
- kernel space [no preempt]
disabled interrupts should usually not be the case.


Jan Engelhardt
-- 
No TOFU for me, please.
