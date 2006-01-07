Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWAGNVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWAGNVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWAGNVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:21:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932725AbWAGNVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:21:12 -0500
Date: Sat, 7 Jan 2006 05:20:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/2] swsusp: low level interface
Message-Id: <20060107052049.43ded9fd.akpm@osdl.org>
In-Reply-To: <200601071336.59242.rjw@sisk.pl>
References: <200601071328.39707.rjw@sisk.pl>
	<200601071336.59242.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
>  This patch introduces the low level interface that can be used for handling
>  the snapshot of the system memory by the in-kernel swap-writing/reading
>  code of swsusp and the userland interface code (to be introduced shortly).

It's a bit sad the way this code goes poking around in swap internals. 
Would it be neater to create a few helper functions over in mm/ and call
them?

This patch needs pretty much all of its inlines removed.  It's way over the
top.

