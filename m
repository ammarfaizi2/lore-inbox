Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVHAPNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVHAPNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVHAPNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:13:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:26266 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262100AbVHAPN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:13:27 -0400
Subject: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 17:09:31 +0200
Message-Id: <1122908972.18835.153.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Why are we calling driver suspend routines in these ? This is _not_ a
good idea ! On various machines, the mecanisms for shutting down are
quite different from suspend/resume, and current drivers have too many
bugs to make that safe. I keep getting all sort of reports of machines
not shutting down anymore.

Ben.


