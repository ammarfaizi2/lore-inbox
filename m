Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVBFSlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVBFSlG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVBFSlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:41:06 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:6708 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261276AbVBFSio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:38:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=A2sYREZJJCSn1sDgMleY42Nuqzpvm6f13CeRc3eDLLbzzUTH7jY4lOqf1X3m13aNFCfriEzAMMhs1thdoqGlnHs5XE62CegTJWiyt0NmSjTeUe4yfWNztZAUA/crXPPHw9z17GHzPGOqTTZnwzM+ZDZKjARuNQVXwmJwpj7yYvg=
Message-ID: <58cb370e050206103817d11145@mail.gmail.com>
Date: Sun, 6 Feb 2005 19:38:40 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 05/09] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050205021556.CFCE41326F9@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050205021502.GA17767@htj.dyndns.org>
	 <20050205021556.CFCE41326F9@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Feb 2005 11:15:56 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:

> -       int err = 0;
> -       u8 args[7], *argbuf = args;
> -       int argsize = 7;
> +       u8 args[7];
> +       ide_task_t task;
> +       task_ioreg_t *regs = task.tfRegister;

u8 *regs please

> +       int ret;

What is the reason for changing the name of variable
(other than making the patch bigger ;) ?

Please also read comments to patch #4.

Thanks,
Bartlomiej
