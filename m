Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265846AbUAECJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 21:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUAECJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 21:09:45 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:461 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265846AbUAECJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 21:09:43 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
References: <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
	<20040104000840.A3625@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
	<20040104034934.A3669@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
	<20040104142111.A11279@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	<20040104230104.A11439@pclin040.win.tue.nl>
	<200401042335.i04NZqQZ029910@turing-police.cc.vt.edu>
	<87k747w4ow.fsf@jbms.ath.cx>
	<20040105015828.GA4176@parcelfarce.linux.theplanet.co.uk>
From: Jeremy Maitin-Shepard <jbms@attbi.com>
Date: Sun, 04 Jan 2004 21:12:22 -0500
In-Reply-To: <20040105015828.GA4176@parcelfarce.linux.theplanet.co.uk> (viro@parcelfarce.linux.theplanet.co.uk's
 message of "Mon, 5 Jan 2004 01:58:28 +0000")
Message-ID: <87hdzbta7t.fsf@jbms.ath.cx>
User-Agent: Gnus/5.1005 (Gnus v5.10.5) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:

> On Sun, Jan 04, 2004 at 08:43:27PM -0500, Jeremy Maitin-Shepard wrote:
>> Unfortunately, programs such as tar depend on inode numbers of distinct
>> files being distinct even when the file is not open over a period of
>> several minutes/seconds.  This is needed to avoid dumping hard links
>> more than once.  Furthermore, there is no efficient way to write
>> programs such as tar without depending on this capability.  Thus, if
>> st_ino cannot be used reliably for this purpose, it would be useful for
>> there to be a system call for retrieving a true
>> unique-within-the-filesystem identifier for the file.

> No such thing.  It's not the matter of having a syscall to extract such
> identifier - it's that on a lot of filesystems (including many common Unix
> ones) there's nothing that would qualify.

Even if the files in question aren't being modified, created, deleted,
etc.?  Even if nothing on the filesystem is being modified, created,
deleted, etc.?

> [snip]

-- 
Jeremy Maitin-Shepard
