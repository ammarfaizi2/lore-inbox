Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTICULz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTICUKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:10:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:50845 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264307AbTICUG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:06:26 -0400
Date: Wed, 3 Sep 2003 22:05:54 +0200
From: Sebastian Reichelt <SebastianR@gmx.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.21] orinoco_cs card reinsertion
Message-Id: <20030903220554.70356a21.SebastianR@gmx.de>
In-Reply-To: <Pine.LNX.4.44.0309031643400.6102-100000@logos.cnet>
References: <20030903213644.1a56a7f2.SebastianR@gmx.de>
	<Pine.LNX.4.44.0309031643400.6102-100000@logos.cnet>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hum, are you using ACPI? There have a few IRQ assignment issues
> reported with the new ACPI in 2.4.22.
> 
> Can you please try booting with "pci=noacpi" option ? 

Yes, thanks. That solves both problems (the reinsertion detection and
the crash). I still get the message "orinoco_lock() called with
hw_unavailable" in syslog, just in case that means something.

Speaking about messages, ever since I've been using PCMCIA (the
SourceForge stuff for 2.2 and the kernel support in 2.4), I've been
getting the following message three times in a row after insertion:
eth1: Error -110 setting multicast list.

I was told on SourceForge that I should just ignore it. However, it
covered by login prompt, so I simply commented out everything about
"multicasting" in orinoco.c. Is there a correct way to handle this?

-- 
Sebastian Reichelt
