Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWCNHQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWCNHQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbWCNHQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:16:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751727AbWCNHQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:16:36 -0500
Date: Mon, 13 Mar 2006 23:14:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do I get the ext3 driver to shut up?
Message-Id: <20060313231407.7606f0d3.akpm@osdl.org>
In-Reply-To: <200603132218.39511.rob@landley.net>
References: <200603132218.39511.rob@landley.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> wrote:
>
> I'm making a test suite for busybox mount, which does filesystem autodetection 
>  the easy way (try all the ones in /etc/filesystems and /proc/filesystems 
>  until one of them succeeds).  My test code is creating and mounting vfat and 
>  ext2 filesystems.
> 
>  Guess which device driver feels a bit chatty?
> 
> ...
>
>  VFS: Can't find ext3 filesystem on dev loop0.

That's only printed if the sys_mount() caller set MS_VERBOSE in `flags'.
