Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754228AbWKMHjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbWKMHjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 02:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbWKMHjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 02:39:13 -0500
Received: from ns1.suse.de ([195.135.220.2]:2950 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754226AbWKMHjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 02:39:13 -0500
Date: Mon, 13 Nov 2006 08:35:33 +0100
From: Stefan Seyfried <seife@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061113073533.GA18022@suse.de>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061109232438.GS30653@agk.surrey.redhat.com> <20061109233258.GH2616@elf.ucw.cz> <200611101303.33685.rjw@sisk.pl> <20061112184310.GC5081@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061112184310.GC5081@ucw.cz>
X-Operating-System: openSUSE 10.2 (i586) Beta2, Kernel 2.6.18.2-4-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 06:43:10PM +0000, Pavel Machek wrote:
> Hi!
 
> > (b) it prevents journaling filesystems in general from replaying journals
> > after a failing resume.
> 
> I do not see b) as an useful goal.

I'm not sure, but i guess it also solves "GRUB takes a minute to load kernel
and initrd from /boot on suspended reiserfs"-problem, which i see as a _very_
useful goal.

Often, most of the time needed for resume is spent by GRUB loading the
kernel/initrd from a journaled FS.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
