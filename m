Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTFPRq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTFPRq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:46:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264072AbTFPRqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:46:52 -0400
Date: Mon, 16 Jun 2003 19:00:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.71: no cursor until tty output
Message-ID: <20030616190042.F13312@flint.arm.linux.org.uk>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a bug in fbcon where the soft cursor does not appear
on the screen until some tty output occurs.  I suspect soft cursor is
missing some initialisation somewhere; I have once seen some random garbage
flashing on the screen instead of the cursor, which seems to be where
the cursor is supposed to be.

When tty output occurs, the characters appear where the garbage was, and
the normal cursor appears.

I've noticed this on several fbcon drivers, so I don't believe it is a
generic fbcon bug.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

