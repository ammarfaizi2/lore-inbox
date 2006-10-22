Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWJVUYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWJVUYA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWJVUYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:24:00 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:62353 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751419AbWJVUX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:23:59 -0400
Message-ID: <453BD35F.1030902@drzeus.cx>
Date: Sun, 22 Oct 2006 22:23:59 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Amol Lad <amol@verismonetworks.com>
CC: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Subject: Re: [PATCH] drivers/mmc/mmc.c: Replacing yield() with a better	alternative
References: <1160570743.19143.307.camel@amol.verismonetworks.com>
In-Reply-To: <1160570743.19143.307.camel@amol.verismonetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amol Lad wrote:
> In 2.6, the semantics of calling yield() changed from "sleep for a
> bit" to "I really don't want to run for a while".  This matches POSIX
> better, but there's a lot of drivers still using yield() when they mean
> cond_resched(), schedule() or even schedule_timeout().
> 
> For this driver cond_resched() seems to be a better
> alternative
> 

A version of this patch has been pushed towards Andrew. Thanks for
pointing it out.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
