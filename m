Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbULEC5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbULEC5A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbULEC5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:57:00 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:40329 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261234AbULEC46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:56:58 -0500
To: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: wakeup_pmode_return jmp failing?
In-Reply-To: <41B09D4B.3090906@tmr.com>
References: <41B084B4.1050402@sun.com> <41B084B4.1050402@sun.com> <41B09D4B.3090906@tmr.com>
Date: Sun, 5 Dec 2004 02:56:57 +0000
Message-Id: <E1Cama1-0002Ad-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:

> That's serious, I have an IBM, Tecra, Dell, and Acer, and 5-6 friends 
> running Linux on laptops. Every one (other than the Acer) works with 
> "apm -s" and recovers. Some work with "apm -S". The Acer never had a 2.4 
> kernel, and I haven't rebuilt with apm on 2.6 (or even looked to see if 
> it was supported). All of these suspend fine with ACPI, none ever wakes up.

Most modern hardware doesn't have APM support any more. Tracking these
bugs down is important, otherwise we'll never be able to support
anything that people can actually buy.

For what it's worth, ACPI suspend/resume seems to work on most machines
as of 2.6.9 - the major sticking point is restoring video state, and the
small number of pieces of hardware that still have basic suspend/resume
issues (a lot of VIA-based hardware, at least one HP device). Based on
my tests so far, around 70% of machines ought to have a semi-reasonable
chance of working ACPI S3 nowadays.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
