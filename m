Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbRFVGzq>; Fri, 22 Jun 2001 02:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265353AbRFVGzg>; Fri, 22 Jun 2001 02:55:36 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:8146 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S265320AbRFVGzY>; Fri, 22 Jun 2001 02:55:24 -0400
Date: Fri, 22 Jun 2001 08:49:47 +0200 (CEST)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: Q serial.c
Message-ID: <Pine.LNX.4.21.0106220846150.11538-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
What may happen on a SMP machine if a serial port has been closed and the
closing stage is at shutdown() in serial.c in the call to free_IRQ  and
BEFORE the IRQ is really shutdown, a new character arrives which causes an
IRQ? Is it possible that the OTHER cpu  takes this interrupt and causes a
crash?

Kees

