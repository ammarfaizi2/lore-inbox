Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTIFVWL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 17:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTIFVWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 17:22:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36486 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262001AbTIFVWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 17:22:09 -0400
Date: Sat, 6 Sep 2003 23:22:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mathieu LESNIAK <maverick@eskuel.net>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org, pavel@ucw.cz
Subject: Re: Fs corruption with swsusp in test4-mm6 ?
Message-ID: <20030906212206.GA26916@atrey.karlin.mff.cuni.cz>
References: <3F59A913.1080406@eskuel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F59A913.1080406@eskuel.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> I've tested the latest -mm6 kernel on a Compaq Presario 2157EA laptop 
> (Celeron Mobile 2GHz)
> Everything worked fine until I tested suspend to disk. After resuming, 
> I've got random messages about reiserfs problem on the console :
> 
> vs-4080: reiserfs_free_block: free_block (hda2:95121)[dev:blocknr]: bit 
> already cleared
> Sep  6 10:30:51 herrbach kernel: vs-4080: reiserfs_free_block: 
> free_block (hda2:95122)[dev:blocknr]: bit already cleared
> Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
> of object [689 645 0x0 SD] (nlink == 1) not found (pos 25)
> Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
> of object [689 652 0x0 SD] (nlink == 1) not found (pos 25)
> 
> Please find in attachement 1 syslog showing the suspend / resume cycle 
> and the fs errors.

Be sure to reboot then run reiserfsck.

OHCI lacks suspend/resume support. Turn it off. ... ... but it should
not do this kind of corruption. Can you reproduce this without OHCI?
Can you try -test3?
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
