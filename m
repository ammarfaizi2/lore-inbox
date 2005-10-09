Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVJIWIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVJIWIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 18:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVJIWIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 18:08:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33176 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932293AbVJIWIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 18:08:41 -0400
Date: Sun, 9 Oct 2005 23:08:38 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
Message-ID: <20051009220838.GN7992@ftp.linux.org.uk>
References: <20051009195850.27237.90873.stgit@zion.home.lan> <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org> <43497533.6090106@utah-nac.org> <20051009212916.GM7992@ftp.linux.org.uk> <43497B09.3020102@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43497B09.3020102@utah-nac.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 02:18:17PM -0600, jmerkey wrote:
> If they all use the same on disk formats as their basic structure,

ext3 and reiserfs?  No, they do not.

> fsck 
> should not return gt > 1 due to misinterpreting reiser on-disk 
> structures. It should say "oh not one of mine, skipping". Instead it 
> returns an error claiming massive corruption, and halts the system. I 
> just upgraded my wifes computer from Suse to RedHat FC4 and when it hits 
> the reiser partitions, the whole system explodes due to fsck.ext3 
> misrecognizing reiser partitions.

Since when does fsck run fsck.ext3 on filesystems that are not marked
as ext3 in /etc/fstab?

>I had to modify rc.sysinit and blank 
> the partitions with fdisk to get it to install. After it installed, I 
> recreated the partitions (after writing down what they were in the first 
> place for block #'s etc.) and disabled rc.sysinit checks. This is 
> busted. Hans needs to fix fsck.ext3 and submit a patch or redhat does.

Sorry, but I doubt that Hans or anybody in RH knows how to patch wetware,
let alone one as messed up as yours.
