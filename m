Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbUKRDAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbUKRDAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUKRDAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:00:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:62682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262376AbUKRC5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:57:18 -0500
Date: Wed, 17 Nov 2004 18:56:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Ian.Pratt@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       alan@redhat.com
Subject: Re: [patch 3] Xen core patch : runtime VT console disable
Message-Id: <20041117185652.6f8386af.akpm@osdl.org>
In-Reply-To: <E1CUZZz-00055l-00@mta1.cl.cam.ac.uk>
References: <E1CUZZz-00055l-00@mta1.cl.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
>
>  --- pristine-linux-2.6.9/drivers/char/tty_io.c  2004-10-18 22:54:32.000000000 +0100
>  +++ linux-2.6.9-xen-sparse/drivers/char/tty_io.c        2004-11-17 01:51:48.000000000 +0000
>  @@ -131,6 +131,8 @@ LIST_HEAD(tty_drivers);                     /* linked list
>      vt.c for deeply disgusting hack reasons */
>   DECLARE_MUTEX(tty_sem);

This patch has had its tabs replaced by spaces.


>  +int console_use_vt = 1;

Should this not have static scope?
