Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSJQIfl>; Thu, 17 Oct 2002 04:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbSJQIfl>; Thu, 17 Oct 2002 04:35:41 -0400
Received: from kim.it.uu.se ([130.238.12.178]:9917 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261870AbSJQIfk>;
	Thu, 17 Oct 2002 04:35:40 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15790.30657.234936.840909@kim.it.uu.se>
Date: Thu, 17 Oct 2002 10:41:37 +0200
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.42+ reboot kills Dell Latitude keyboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell Latitude CPi laptop. Boot 2.5.42 or .43, then reboot.
Shortly after the screen is blanked and the BIOS starts, it
prints a "keyboard error" message and requests an F1 or F2
response (continue or go into SETUP). Never happened with any
other kernel on that machine.

Apparently the 2.5.42+ "let's shut everything down at reboot"
change put the keyboard controller in a state which is inconsistent
with the BIOS' expections at a warm boot.

First the disks-spun-down-at-reboot bug and now this. Sigh.
