Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265820AbUGDWNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUGDWNH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUGDWNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:13:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34521 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265820AbUGDWND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:13:03 -0400
Date: Sun, 4 Jul 2004 23:13:02 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-ID: <20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk>
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040703202541.GA11398@infradead.org> <20040703133556.44b70d60.akpm@osdl.org> <20040703210407.GA11773@infradead.org> <20040703143558.5f2c06d6.akpm@osdl.org> <20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk> <20040704145542.4d1723f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704145542.4d1723f5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:55:42PM -0700, Andrew Morton wrote:
> 
> Some do.  On my test box 1000-odd /proc inodes get allocated and fully
> freed on each `ls -R /proc'.  65 /proc inodes are freed during `ls -lR
> /proc/net'.  So maybe it isn't working completely.
> 
> But proc_notify_change() copies the inode's uid, gid and mode into the
> proc_dir_entry, so they get correctly initialised when the inode is
> reinstantiated, so afaict we have no bug here.

Why on the earth do we ever want to allow chown/chmod on procfs in the first
place?

Al, who'd missed that stuff back in 2.5.42, but would love to hear explanation
anyway.
