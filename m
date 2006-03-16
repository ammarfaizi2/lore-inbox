Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWCPXzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWCPXzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWCPXzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:55:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964912AbWCPXzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:55:44 -0500
Date: Thu, 16 Mar 2006 15:58:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6-m1 PATCH] Connector: Filesystem Events Connector
 try 2
Message-Id: <20060316155801.298e7e9e.akpm@osdl.org>
In-Reply-To: <44198795.2080407@gmail.com>
References: <44198795.2080407@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yi Yang <yang.y.yi@gmail.com> wrote:
>
> This new patch is update for last patch, it removes spinlock and
> makes include/linux/fsnotify.h more clean when CONFIG_FS_EVENTS=n,
> it also reformats some too long lines so that they are less than 80
> columns.
> 
> This patch implements a new connector, Filesystem Event Connector,
>  the user can monitor filesystem activities via it, currently, it
>  can monitor access, attribute change, open, create, modify, delete,
>  move and close of any file or directory.
> 
> Every filesystem event will include tgid, uid and gid of the process
>  which triggered this event, process name, file or directory name 
> operated by it.

That would seem to have some privacy implications...

I'd expect that all the info which is needed can be obtained via syscall
auditing.

I don't recall having seen demand for this feature before.  For what reason
is it needed?  What is the application?
