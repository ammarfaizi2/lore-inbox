Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVHWATs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVHWATs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVHWATs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:19:48 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:12183 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751278AbVHWATr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:19:47 -0400
Subject: Re: [PATCH] race condition with drivers/char/vt.c (bug in
	vt_ioctl.c)
From: Steven Rostedt <rostedt@goodmis.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <430A6902.7060304@gmail.com>
References: <1124508087.18408.79.camel@localhost.localdomain>
	 <430A6902.7060304@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 22 Aug 2005 20:19:18 -0400
Message-Id: <1124756358.5350.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 08:08 +0800, Antonino A. Daplas wrote:
> There's a similar report in Kernel Bugzilla
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4812
> 
> I was wondering what's the likelihood of tty->driver_data being NULL in
> vt_ioctl but never had the time to do further exploration. Your patch
> should fix that bug too.
> 

Yep, that's the bug that is fixed with this patch, so you can close it
out. Well, not until it's added to the mainline (akpm already added it
to -mm).  I wouldn't check for tty->driver_data == NULL, since that
would have been hiding the problem, and not solving it.

-- Steve


