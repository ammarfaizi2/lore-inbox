Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270114AbTGUOIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270115AbTGUOID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:08:03 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:12674 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S270114AbTGUOH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:07:59 -0400
Date: Mon, 21 Jul 2003 16:23:00 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: siginfo pad problem.
Message-ID: <20030721142259.GA4315@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the _timer part of siginfo is a little bit broken.

It has:
                        char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];

Where __ARCH_SI_UID_T can be a short.

I have no idea if on any arch it can be bigger than an int.


Kurt

