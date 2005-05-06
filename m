Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVEFWIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVEFWIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVEFWIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:08:39 -0400
Received: from ns.suse.de ([195.135.220.2]:55018 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261299AbVEFWIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:08:20 -0400
Message-ID: <427BE2CA.7030007@suse.de>
Date: Fri, 06 May 2005 23:34:02 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.12-rc3][SUSPEND] qla1280 (QLogic 12160 Ultra3) blows up
 on A7M266-D
References: <20050503181018.37973.qmail@web88008.mail.re2.yahoo.com>
In-Reply-To: <20050503181018.37973.qmail@web88008.mail.re2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> I was feeling lucky yesterday and decided to try my
> luck on an A7M266-D with suspend-to-disk. I noticed
> two things

> 1) If I use XFS /w the SCSI controller (connected to 2
> IBM HD 10K Ultra3 SCSI disks) I can suspend to disk no
> problem, but resuming all hell breaks loose. It takes
> a half an hour to reload the swap memory dumped to
> disk.

Known, XFS was broken / breaking wrt suspend. Pavel fixed this with the
XFS guys IIRC and i think those patches were on lkml also, but am not
sure. => this should work soon.

> 2) If I use EXT3, suspending to disk is fine resuming
> is fine there is no long delay to load the swap memory
> back to RAM. But when it finishes resuming I get the
> same ISP error and the partition table gets corrupt as
> well.

> Is it likely this SCSI driver doesn't know how to
> handle suspend events?

Yes. Almost all drivers that are not commonly used in notebooks are
totally ignorant of suspend / resume. Even the brand new SATA driver
stuff (that is actually in almost every new notebook) had no suspend
support until some days ago.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out."

