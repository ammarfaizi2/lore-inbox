Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVHaDdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVHaDdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 23:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVHaDdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 23:33:33 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9416 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S932342AbVHaDdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 23:33:33 -0400
Subject: Re: inotify and IN_UNMOUNT-events
From: Robert Love <rml@novell.com>
To: Juergen Quade <quade@hsnr.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050830194632.GA13346@hsnr.de>
References: <20050830194632.GA13346@hsnr.de>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 23:33:27 -0400
Message-Id: <1125459207.32272.114.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 21:46 +0200, Juergen Quade wrote:
> Playing around with inotify I have some problems
> to generate/receive IN_UNMOUNT-events (using
> a self written application and inotify_utils-0.25;
> kernel 2.6.13).
> 
> Doing:
> - mount /dev/hda1 /mnt
> - add a watch to the path /mnt/ ("./inotify_test /mnt")
> - umount /mnt
> 
> results in two events:
> 1. IN_DELETE_SELF (mask=0x0400)
> 2. IN_IGNORED     (mask=0x8000)
> 
> Any ideas?

"/mnt" is not unmounted, stuff inside of it is.

Watch, say, "/mnt/foo/bar" and when /dev/hda1 is unmounted, you will get
an IN_UNMOUNT on the watch.

	Robert Love


