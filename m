Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284085AbRLAMhZ>; Sat, 1 Dec 2001 07:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284089AbRLAMhF>; Sat, 1 Dec 2001 07:37:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55305 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284085AbRLAMgy>; Sat, 1 Dec 2001 07:36:54 -0500
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Sat, 1 Dec 2001 12:45:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0112011336040.11026-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Dec 01, 2001 01:36:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A9WI-00073W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO this is precisely the wrong thing to do.

We should make the = NULL check within kfree do a BUG() call. That way we
fix the cases not being considered instead of hiding real bugs
