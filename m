Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVDBWUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDBWUm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVDBWUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:20:03 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:24840 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261320AbVDBWRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:17:08 -0500
Date: Sun, 3 Apr 2005 00:16:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Uwe Zybell <u_zybell@yahoo.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: fs/partitions/msdos.c, scripts/packages/Makefile
Message-ID: <20050402221658.GA5909@pclin040.win.tue.nl>
References: <20050401171852.36514.qmail@web25603.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401171852.36514.qmail@web25603.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : pastinakel.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 07:18:52PM +0200, Uwe Zybell wrote:

> There is a line in fs/partitions/msdos.c that lets extended partitions 
> be max 1k (..."==1 ? 1 : 2"...). The comment explains it to protect 
> sysadmins from themselves. But now I have found a legitimate use
> for extended partitions in their full length. Emulation.
> Please remove this, or make it a config option.

Config options are evil. Adding them is a bad form of bloat.

Whatever you want to do, there are many ways to do it without
changing this part of the kernel code. After all, any partition
is just part of the entire disk.

Note that there are aliasing problems - it is bad to access data
both via a file system and via raw disk or partition.

Andries
