Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVG2DvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVG2DvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVG2DvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:51:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262258AbVG2DvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:51:19 -0400
Date: Thu, 28 Jul 2005 20:50:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syncing single filesystem (slow USB writing)
Message-Id: <20050728205016.1bdf7288.akpm@osdl.org>
In-Reply-To: <200507290731.32694.arvidjaar@mail.ru>
References: <200507290731.32694.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> Mandrake always mounted USB sticks with sync option; it was effectively noop 
> except for a patch that implemented limited dsync semantic.
> 
> Now, when full sync support for FATis in kernel, moutning with sync became 
> real pain. Writing speed dropped from 3MB/s to 30KB/s in my case (and I am 
> not alone).

Unfortunately I think we're just going to have to live with that.  It is
right that fatfs behaves as it does, and unfortunate that some distros will
operate slowly.

For reference: how does mandrake implement this?  Just in /etc/fstab?  How
should we tell other people to fix this?

> One idea how to improve situation - continue to mount with dsync (having 
> basically old case) and do frequent sync of filesystem (this culd be started 
> as HAL callout or whatever). Unfortunately, I could not find a way to request 
> a sync (flush) of single mount point or block device. Have I missed 
> something?

It's trivial to do in-kernel but no, I'm afraid there isn't a userspace
interface for this.

