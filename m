Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSI1LqG>; Sat, 28 Sep 2002 07:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261266AbSI1LqF>; Sat, 28 Sep 2002 07:46:05 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:17297 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261263AbSI1LqF>;
	Sat, 28 Sep 2002 07:46:05 -0400
Date: Sat, 28 Sep 2002 06:51:23 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.39
In-Reply-To: <Pine.LNX.4.33.0209271459210.1807-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209280646580.2069-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, Linus Torvalds wrote:

> 
> Changes all over the map.

The following patch is still needed:


--- linux-2.5-tm/sound/oss/v_midi.h.old	Sun Sep 22 10:01:43 2002
+++ linux-2.5-tm/sound/oss/v_midi.h	Sun Sep 22 10:02:48 2002
@@ -11,5 +11,6 @@
 	   int input_opened;
 	   int intr_active;
 	   void (*midi_input_intr) (int dev, unsigned char data);
+	   spinlock_t lock;
 	} vmidi_devc;
 

