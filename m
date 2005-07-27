Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVG0S7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVG0S7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVG0S6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:58:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:39081 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262453AbVG0Srv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:47:51 -0400
Date: Wed, 27 Jul 2005 20:47:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Capability ingranularity
Message-ID: <Pine.LNX.4.61.0507272045180.20942@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello developers,


I am currently writing a LSM security module. Because of how many functions 
work, I have to add CAP_SYS_ADMIN to the effective capabilities of the 
implemented "medium-privileged root" user. However, CAP_SYS_ADMIN is used in a 
_lot_ of places, so I need to add security_*() hooks for many functions that 
just return EPERM should current->euid be MediumPriv.
If you just look at include/linux/capabilities.h and look at the long list of 
what CAP_SYS_ADMIN enables, this might sound like an overkill. Is there a 
better way to do this?



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
