Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVHNMwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVHNMwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVHNMwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:52:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932514AbVHNMwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:52:36 -0400
Subject: Re: Changing thread_info->task, does it harm?
From: Arjan van de Ven <arjan@infradead.org>
To: Samer Sarhan <samersarhan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ahmed Mohamed Tarek <ahmadtarek@gmail.com>
In-Reply-To: <f03ab5ae05081405411da7f70@mail.gmail.com>
References: <f03ab5ae05081405411da7f70@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 14 Aug 2005 14:52:24 +0200
Message-Id: <1124023944.7041.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-14 at 15:41 +0300, Samer Sarhan wrote:
> Hi,
> I had a design problem of a Linux module (Linux 2.6.11) that lead me to do this:
> 
> int work_fn(void* data);
> task_t my_task;
> task_t* kthread = kthread_create(work_fn, NULL, "Task 1");
> // assume kthread create was successfully...
> my_task = *kthread;
> // change what current maceo points to...
> kthread->thread_info->task = &my_task;
> ...


why ?


> well... is it dangerous to change what current macro points to through
> changing thread_info->task?

it most likely is.

1) Why do you think you need to do this ??
2) What are you trying to solve?
3) What is the URL to the sourcecode of your module ?


