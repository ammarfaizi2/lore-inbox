Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWHMVLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWHMVLG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWHMVLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:11:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:35990 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751477AbWHMVLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:11:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 0/2] Detect clock skew during suspend
Date: Sun, 13 Aug 2006 23:02:59 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608132303.00012.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If the CMOS timer is changed when the system is suspended to disk in such a
way that the time during the resume turns out to be earlier than the time
before the suspend, the resume often fails and the system hangs (spins
forever in the idle thread) due to driver problems.

For this reason it seems reasonable to make the timer .resume() routines
detect such situations and prevent them from happening, which is done
in the following two patches for i386 and x86_64.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

