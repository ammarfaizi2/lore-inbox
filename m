Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbUCLWr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCLWr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:47:28 -0500
Received: from gprs40-129.eurotel.cz ([160.218.40.129]:23170 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263009AbUCLWr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:47:27 -0500
Date: Fri, 12 Mar 2004 23:46:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Dealing with swsusp vs. pmdisk
Message-ID: <20040312224645.GA326@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I don't really like having two implementations of same code in
kernel. There are two ways to deal with it:

* remove pmdisk from kernel
  + its easy

* remove swsusp from kernel, rename pmdisk to swsusp, fix all bugs
  that were fixed in swsusp but not in pmdisk 
  + people seem to like pmdisk code more
  - will need some testing in -mm series

Which one do you prefer? I can do both...
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
