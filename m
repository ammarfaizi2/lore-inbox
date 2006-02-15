Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422899AbWBOHBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422899AbWBOHBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422902AbWBOHBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:01:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422899AbWBOHBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:01:05 -0500
Date: Tue, 14 Feb 2006 22:59:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: psusi@cfl.rr.com, jzb@aexorsyst.com, linux-kernel@vger.kernel.org
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
Message-Id: <20060214225950.3a697ec8.akpm@osdl.org>
In-Reply-To: <20060214162458.GD27946@ftp.linux.org.uk>
References: <200602132316.15992.jzb@aexorsyst.com>
	<43F1FA74.80607@cfl.rr.com>
	<20060214162458.GD27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> Read init/do_mounts.c::name_to_dev_t().
>

I tried to do that a while ago, when I was trying to use it for
name_to_dev_t()ing in swsusp somewhere.


>From my notes at the time:

  a) It barfs if /sys is already mounted.

  b) Fix that, mkdir and mount barf because it needs set_fs(KERNEL_DS)

  c) Fix that, it barfs because name_to_dev_t is just broken.  It is
     accessing the wrong pathnames in /sys.

I think it needs a bit of help.
