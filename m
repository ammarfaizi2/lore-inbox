Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266264AbUAVOJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 09:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUAVOJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 09:09:49 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:59546 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266264AbUAVOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 09:09:47 -0500
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
In-Reply-To: <m3hdyo2kce.fsf@reason.gnu-hamburg>
References: <m3hdyo2kce.fsf@reason.gnu-hamburg>
Message-Id: <E1AjfWl-0006f8-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Thu, 22 Jan 2004 14:09:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>on an ASUS M2400N [*] with both plain vanilla Linux Kernel 2.6.1 and
>2.6.1 + acpi-20031203, the machine appears to suspend to RAM without a
>problem and it also apparently comes back, but the screen is dead.

Try passing acpi_sleep=s3_bios or acpi_sleep=s3_mode to the kernel on
boot - also try while running X, switch away before suspend and switch
back afterwards. The problem is that the kernel doesn't know how to wake
the video hardware back up after S3 - the kernel parameters are hacks
that try to provoke it back into life, and X is sometimes able to
reinitialise stuff itself.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
