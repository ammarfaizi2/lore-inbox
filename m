Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUKOKXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUKOKXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 05:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUKOKXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 05:23:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63382 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261564AbUKOKXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 05:23:37 -0500
Date: Mon, 15 Nov 2004 11:23:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stephan Menzel <stephan42@chinguarime.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [FS] New monitor framework in 2.6.10?
In-Reply-To: <200411151113.06386.stephan42@chinguarime.net>
Message-ID: <Pine.LNX.4.53.0411151121240.6893@yvahk01.tjqt.qr>
References: <200411151113.06386.stephan42@chinguarime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>i'm maintaining a kernel patch which is monitoring file system activity
>underneath a special directory tree and reporting occuring events via a
>character device to userland where it is processed.
>Right now, this patch works via a number of hooks in fs/read-write.c and
>fs/namei.c.
>This is not really efficient at the moment because this way I get an event for
>any written block and not per file which can slow things down a lot.
>A couple of days ago I heard rumours about a new feature in 2.6.10 which will
>be exactly for this kind of purpose. Some kind of monitor frameworks that can
>generate events for all sorts of things. Sorry, I don't know any more about
>it.

Wasnot it called System Call Auditing and/or Filesystem hooks?

>Is that true?
>Would that be suitable for my task?
>And where can I get information about it?

One or the other was present in SUSE's 2.4.20/.21 kernels and one is in 2.6.x
-- and from what I have seen, they're just hooks, i.e.

if(hook != NULL) { hook(fd, buf, size); }

That's the most efficient thing you can have (in a function). It's only a
question whether it is in the right function, then.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
