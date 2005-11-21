Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVKULUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVKULUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVKULUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:20:13 -0500
Received: from main.gmane.org ([80.91.229.2]:51091 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932252AbVKULUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:20:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@snikt.net>
Subject: Re: what is our answer to ZFS?
Date: Mon, 21 Nov 2005 11:16:52 +0100
Message-ID: <slrndo37kk.cvi.news_0403@localhost.localdomain>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
Reply-To: Andreas Happe <andreashappe@snikt.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello062178006202.3.11.tuwien.teleweb.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-11-21, Alfred Brons <alfredbrons@yahoo.com> wrote:
> Thanks Paulo!
> I wasn't aware of this thread.
>
> But my question was: do we have similar functionality
> in Linux kernel?

>>> Every block is checksummed to prevent silent data corruption,
>>> and the data is self-healing in replicated (mirrored or RAID)
>>> configurations.

should not be filesystem specific.

>>> ZFS provides unlimited constant-time snapshots and clones. A
>>> snapshot is a read-only point-in-time copy of a filesystem, while a
>>> clone is a writable copy of a snapshot. Clones provide an extremely
>>> space-efficient way to store many copies of mostly-shared data such
>>> as workspaces, software installations, and diskless clients.

lvm2 can do those too (with any filesystem that supports resizing).
Clones would be the snapshot functionality of lvm2.

>>> ZFS administration is both simple and powerful.  The tools are
>>> designed from the ground up to eliminate all the traditional
>>> headaches relating to managing filesystems. Storage can be added,
>>> disks replaced, and data scrubbed with straightforward commands.

lvm2.

>>> Filesystems can be created instantaneously, snapshots and clones
>>> taken, native backups made, and a simplified property mechanism
>>> allows for setting of quotas, reservations, compression, and more.

excepct per-file compression all thinks should be doable with normal in-kernel
fs. per-file compression may be doable with ext2 and special patches, an
overlay filesystem or reiser4.

Andreas

