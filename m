Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbULWXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbULWXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbULWXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 18:37:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:29376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261337AbULWXhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 18:37:22 -0500
Date: Thu, 23 Dec 2004 15:37:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jesper Juhl <juhl-lkml@dif.dk>, holt@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AB-BA deadlock between uidhash_lock and tasklist_lock.
In-Reply-To: <20041223153053.173098f5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0412231532470.2654@ppc970.osdl.org>
References: <20041222220800.GB6213@lnx-holt.americas.sgi.com>
 <20041223173749.GA18887@lnx-holt.americas.sgi.com> <20041223145433.596db88c.akpm@osdl.org>
 <Pine.LNX.4.61.0412240019540.3504@dragon.hygekrogen.localhost>
 <20041223153053.173098f5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Dec 2004, Andrew Morton wrote:
> 
> hrm.  Why don't we just do this?

Seems sane enough. Nobody should look at somebody elses user anyway. The
signal code does, though. That's a separate bug (and looks harmless), and
that code doesn't hold tasklist_lock anyway, so the lock doesn't matter
for that thing.

		Linus
