Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751884AbWCGXFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWCGXFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWCGXFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:05:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751884AbWCGXFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:05:50 -0500
Date: Tue, 7 Mar 2006 15:04:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Latchesar Ionkov <lucho@advancedsolutions.com>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] v9fs: fix for access to unitialized variables or freed
 memory
Message-Id: <20060307150422.084f3863.akpm@osdl.org>
In-Reply-To: <20060307124304.GA15195@ionkov.net>
References: <20060306070456.GA16478@redhat.com>
	<f158dc670603061749t18196e63tab3409441942ac3@mail.gmail.com>
	<20060307124304.GA15195@ionkov.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latchesar Ionkov <lucho@advancedsolutions.com> wrote:
>
> Miscellaneous fixes related to accessing uninitialized variables or memory
> that was already freed.

That part of your patch is applicable to (and needed in) 2.6.16.  (Please
confirm).

> Adds function declarations missed in
> v9fs-print-9p-messages.patch.

And that part is only applicable to a patch which is queued for 2.6.17.

Hence I split your patch into two patches.  The latter one will be folded
into v9fs-print-9p-messages-fix before I send it off to Linus.

The general rule is "one concept per patch", please.  This patch had two.
