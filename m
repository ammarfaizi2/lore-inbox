Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUACSWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUACSWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:22:16 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:57728 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263636AbUACSWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:22:15 -0500
Date: Sat, 3 Jan 2004 19:23:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp in 2.6.0 sometimes reports "incorrect version"
Message-ID: <20040103182332.GA1080@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This check sometimes triggers; I'm not sure what is going on. Adding
field to "struct suspend_head" may help you.

								Pavel


static int sanity_check(struct suspend_header *sh)
{
	if (sh->version_code != LINUX_VERSION_CODE)
		return sanity_check_failed("Incorrect kernel version");

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
