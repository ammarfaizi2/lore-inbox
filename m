Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVKNXJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVKNXJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVKNXJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:09:43 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:19870 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751286AbVKNXJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:09:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] swsusp: improve freeing of memory
Date: Mon, 14 Nov 2005 23:47:57 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511142347.58233.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently swsusp frees as much memory as possible during suspend.  This slows
down the suspend and causes the system to be slow after resume due to
the swapping-in activity.  The following series of patches is designed to
change this behavior so that swsusp will free only as much memory as necessary
to complete the suspend.

The patches have been acked by Pavel (modulo some minor issues related to
the naming of constants, formatting etc. that are hopefully fixed now).

Please consider for applying.

Greetings,
Rafael

