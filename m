Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTLWAim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTLWAil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:38:41 -0500
Received: from vena.lwn.net ([206.168.112.25]:32681 "HELO lwn.net")
	by vger.kernel.org with SMTP id S264881AbTLWAic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:38:32 -0500
Message-ID: <20031223003831.25486.qmail@lwn.net>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, mh@nadir.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 23 Dec 2003 11:22:17 +1100."
             <20031223002217.GC934@krispykreme> 
Date: Mon, 22 Dec 2003 17:38:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	int i, j;
> +	int i = *(int *) v, j;

> That int * has to be a loff_t * or bad things will happen on a 64bit big
> endian platform :)

You mean the world's not all an x86?  What are things coming to?

Andrew, Marc, this seems almost certain to the the source of the problem
you brought to my attention.  I'll try to get a supplemental patch to you
tomorrow.  Obviously, it should be a loff_t for all architectures, even if
it works for most now.

Thanks,

jon
