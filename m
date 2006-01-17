Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWARA12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWARA12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWARA12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:27:28 -0500
Received: from [151.97.230.9] ([151.97.230.9]:8675 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964909AbWARA11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:27:27 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 0/9] UML various fixes for 2.6.16
Date: Wed, 18 Jan 2006 00:36:38 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060117233638.11685.53269.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge various fixes, mainly for locking issues.

A bit of attention is to give to "uml: avoid malloc to sleep in atomic
sections". It's really an hack, but we already use this hack in a more buggy
way (see the patch).

In practice, when malloc() is called, it's translated in
a call to kmalloc(GFP_?), where ATOMIC or KERNEL is used depending on
in_atomic() and in_interrupt().
--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
