Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVCOFOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVCOFOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVCOFOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:14:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:40380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262261AbVCOFOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:14:36 -0500
Date: Mon, 14 Mar 2005 21:14:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TTY] overrun notify issue during 5 minutes after booting
Message-Id: <20050314211421.77652d4a.akpm@osdl.org>
In-Reply-To: <20050314141754.8178.qmail@web25108.mail.ukl.yahoo.com>
References: <20050314141754.8178.qmail@web25108.mail.ukl.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis <francis_moreau2000@yahoo.fr> wrote:
>
> By the way, is it safe in "n_tty_receive_overrun" to
>  call
>  "printk" ? because the former can be called from IT
>  context...

yup.  printk() is safe from all contexts except NMI.
