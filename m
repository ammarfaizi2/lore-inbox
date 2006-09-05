Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWIENwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWIENwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWIENwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:52:44 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:57504 "EHLO
	mail.lysator.liu.se") by vger.kernel.org with ESMTP id S964908AbWIENwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:52:43 -0400
To: linux-kernel@vger.kernel.org
Subject: VFAT truncate performance
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: =?iso-8859-1?Q?Mattias_R=F6nnblom?= <hofors@lysator.liu.se>
Date: 05 Sep 2006 15:52:46 +0200
Message-ID: <m3mz9e5sk1.fsf@isengard.friendlyfire.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

extending files by ftruncate(2) runs very slow on VFAT file
systems. On my USB harddisk w/ VFAT, it takes 14 seconds to extend an
empty file to 1 GB. On a memory stick, it takes well over 4 minutes.

My question is: is this problem on the conceptual level (ie there is
no way of extending files on FAT that doesn't involve many disk
operations) or is the current Linux fs driver suboptimal in this
respect?

The reason for asking is that I run Samba which service files on USB
devices (w/ VFAT for portability) to Windows XP clients. When copying
files to the Samba server, Microsoft SMB clients seem to extend the
file before actually starting to copy the data. This results in
sluggishness and timeouts when copying large files to VFAT
filesystems.

Thanks,
        Mattias

