Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVAPEjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVAPEjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVAPEjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:39:22 -0500
Received: from gsstark.mtl.istop.com ([66.11.160.162]:7138 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S262425AbVAPEjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:39:11 -0500
To: William <wh@designed4u.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
References: <200412311741.02864.wh@designed4u.net>
In-Reply-To: <200412311741.02864.wh@designed4u.net>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 15 Jan 2005 23:39:00 -0500
Message-ID: <87brbqt2cb.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William <wh@designed4u.net> writes:

> In my opinion, in order for linux to be trully user friendly, "a umount() 
> should NEVER fail" (even if the device containing the filesystem is no 
> longuer attached to the system). The kernel should do it's best to satisfy 
> the umount request and cleanup. Maybe the kernel could try some of the 
> following:

What you're asking for is for the umount -f option to be supported. This isn't
a new fangled idea. BSD supported has supported it since sometime in the last
millennium. Seriously, it's pretty basic functionality and really ought to be
supported.

The semantics of umount -f are simpler than you make it sound. It just
unmounts the file system normally and revokes any file descriptors for that
file system. Any further i/o on those file descriptors just gets an error
(EINVAL I expect). 

This is one of my biggest pet peeves about Linux.

-- 
greg

