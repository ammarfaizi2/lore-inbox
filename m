Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264335AbUFHVY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbUFHVY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUFHVY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:24:56 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S264335AbUFHVYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:24:55 -0400
Date: Wed, 9 Jun 2004 00:24:53 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082124.i58LOrMm016152@melkki.cs.helsinki.fi>
Subject: [RFC][PATCH] ALSA: Remove subsystem-specific malloc (0/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a kcalloc() and replaces ALSA magic allocator
snd_kcalloc() and snd_magic_kcalloc() with it.  I also fixed a memory
leak in the arm sa11xx driver and added a BUG() in seq_oss_synth to
catch failing allocations.

I kept the snd_magic_cast macro in place just in case someone wants to
add a generic type checking facility in the kernel and convert the users
to use it.

The patch is against 2.6.6 and was compile-tested with allyesconfig.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
