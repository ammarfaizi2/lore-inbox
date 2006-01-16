Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWAPNzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWAPNzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWAPNzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:55:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22460 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750757AbWAPNzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:55:16 -0500
Date: Mon, 16 Jan 2006 14:21:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: find reports badness on /proc (2.6.15-dirty)
Message-ID: <20060116132104.GA1595@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

$ find . -name "*dmi*"
find: ./1519/task/1519/fd: Permission denied
find: ./1519/fd: Permission denied
find: ./1520/task/1520/fd: Permission denied
find: ./1520/fd: Permission denied
find: ./1521/task/1521/fd: Permission denied
find: ./1521/fd: Permission denied
find: ./1578/task/1578/fd: Permission denied
find: ./1578/fd: Permission denied
find: WARNING: Hard link count is wrong for .: this may be a bug in
your filesystem driver.  Automatically turning on find's -noleaf
option.  Earlier results may have failed to include directories that
should have been searched.
pavel@amd:/proc$

...strange. I re-tried the search, and warning went away. Is it known
race?

								Pavel
-- 
Thanks, Sharp!
