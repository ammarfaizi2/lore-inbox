Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWFZGXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWFZGXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWFZGXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:23:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964824AbWFZGXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:23:23 -0400
Date: Sun, 25 Jun 2006 23:23:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: CONFIG_PM_TRACE corrupts RTC
Message-Id: <20060625232322.af3f4f6c.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a Sony Vaio, after a suspend-to-disk and a resume, `hwclock' says

  The Hardware Clock registers contain values that are either invalid
  (e.g.  50th day of month) or beyond the range we can handle (e.g.  Year
  2095).

and after a reboot the machine takes a trip back to 1969.  Setting
CONFIG_PM_TRACE=n prevents this.
