Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVC0Xma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVC0Xma (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVC0Xma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:42:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:48840 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261601AbVC0Xm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:42:27 -0500
Subject: Mac mini sound woes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 09:42:00 +1000
Message-Id: <1111966920.5409.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi !

I'm looking into adding proper sound support for the Mac Mini. The
problem is that from what I've seen (Apple driver is only partially
opensource nowadays it seems, and the latest darwin drop is both
incomplete and doesn't build), that beast only has a fixed function D->A
converter, no HW volume control.

It seems that Apple's driver has an in-kernel framework for doing volume
control, mixing, and other horrors right in the kernel, in temporary
buffers, just before they get DMA'ed (gack !)

I want to avoid something like that. How "friendly" would Alsa be to
drivers that don't have any HW volume control capability ? Does typical
userland libraries provide software processing volume control ? Do you
suggest I just don't do any control ? Or should I implement a double
buffer scheme with software gain as well in the kernel driver ?

Ben.



