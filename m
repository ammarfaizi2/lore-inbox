Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266239AbUAVKps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUAVKps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:45:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:29095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266239AbUAVKpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:45:46 -0500
Date: Thu, 22 Jan 2004 02:46:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] sisfb update 2.6.1
Message-Id: <20040122024617.60ee802a.akpm@osdl.org>
In-Reply-To: <400FA3CD.1030008@winischhofer.net>
References: <400F0F8C.8070900@winischhofer.net>
	<20040121160309.2fd26f0a.akpm@osdl.org>
	<400F9055.5050206@winischhofer.net>
	<20040122012312.1f26fad8.akpm@osdl.org>
	<400FA3CD.1030008@winischhofer.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer <thomas@winischhofer.net> wrote:
>
> 
> Andrew Morton wrote:
> > 
> > Well darn, that patch fixed the wrong bit and we still have float in there.
> > allmodconfig doesn't pick this up.
> > 
> > 
> > drivers/built-in.o: In function `sisfb_do_set_var':
> > //drivers/video/sis/sis_main.c:654: undefined reference to `__floatsidf'
> > ...
> > drivers/built-in.o: In function `sisfb_init':
> > //drivers/video/sis/sis_main.c:4450: undefined reference to `__floatsidf'
> > 
> > Search for "1E12" in sis_main.c
> 
> I did. "Not found."
> 

Ah OK, so you fixed it.  Doh.
