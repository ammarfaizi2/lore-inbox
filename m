Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTHSTJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTHSTG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:06:59 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:45327 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261276AbTHSTGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:06:25 -0400
Date: Tue, 19 Aug 2003 21:06:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
Message-ID: <20030819210623.A2195@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4268C1.9040608@redhat.com>; from drepper@redhat.com on Tue, Aug 19, 2003 at 11:13:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 11:13:21AM -0700, Ulrich Drepper wrote:

> This is a problem which pops up in the glibc test suite.  It's been like
> this for many weeks, even months.  I just hadn't time to investigate.
> But the problem is actually very easy.
> 
> Go into a directory mounted via NFS.  You need write access.  Then
> execute this little program:
> 
> The result is always, 100% of the time, a failure in ftruncate.  The
> kernel reports ESTALE.  This has not been a problem in 2.4 and not even
> in 2.6 until <mumble> months ago.  And of course it works with local disks.

I just tried NFS client 2.6.0-test3, NFS server 2.0.34, try test on client.
No problems. ftruncate did not fail.

(Do you require some NFS version?)

