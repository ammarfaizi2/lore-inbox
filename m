Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUAPUUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUAPUUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:20:14 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:24315 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265628AbUAPUT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:19:59 -0500
Date: Fri, 16 Jan 2004 12:19:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.1 vanilla] Accessing CD-ROM drive causes 94% "hi" load
Message-ID: <20040116201950.GP1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <200401161443.55918@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161443.55918@WOLK>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 02:48:16PM +0100, Marc-Christian Petersen wrote:
> Hello there,
> 
> accessing my CD-ROM drive causes my system to generate 94% "hi" in
> top. I reproduced it using the following steps:
> 
> 1. mount /dev/hda /cdrom
> 2. cat /cdrom/* > /dev/null
> 
> During this timeperiod, the system does almost stop to do any other
> I/O, i.e. accessing my SATA drives on an LVM2 stripeset and doing "cat
> largefile > /dev/null" does not read the usual 60 MB/s but only like 2
> or 3. I am using the anticipatory scheduler, but tried out the
> deadline elevator which doesn't change anything.

Try hdparm -d1 on your cdrom drive.
