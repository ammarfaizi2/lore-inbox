Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUGRXhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUGRXhg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 19:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUGRXhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 19:37:36 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:21418 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264640AbUGRXhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 19:37:34 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 18 Jul 2004 16:37:28 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
Subject: Re: [PATCH] inotify 0.5
In-Reply-To: <1090180167.5079.21.camel@vertex>
Message-ID: <Pine.LNX.4.58.0407181636240.8279@bigblue.dev.mdolabs.com>
References: <1090180167.5079.21.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jul 2004, John McCutchan wrote:

> Inotify is a replacement for dnotify. 
> 
> The main difference between this and my earlier inotify design, is that
> device numbers and inode numbers are no longer used. The interface
> between user and kernel space uses a watcher descriptor.
> 
> inotify is a char device with two ioctls
> 
> WATCH
> 	which takes 
> 
> 	struct inotify_watch_request {
> 	        char *dirname; // directory name
>         	unsigned long mask; // event mask
> 	};
> 
> 	and returns a watcher descriptor (int)

Does such descriptor supports poll(2) (... f_op->poll())?



- Davide

