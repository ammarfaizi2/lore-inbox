Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWJQW4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWJQW4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWJQW4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:56:07 -0400
Received: from c3po.0xdef.net ([217.172.181.57]:33287 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S1750984AbWJQW4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:56:04 -0400
Date: Wed, 18 Oct 2006 00:56:03 +0200
From: Hagen Paul Pfeifer <hagen@jauu.net>
To: Kay Tiong Khoo <kaytiong@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stopping a process during a timer interrupt
Message-ID: <20061017225603.GA15846@c3po.0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hagen@jauu.net>,
	Kay Tiong Khoo <kaytiong@gmail.com>, linux-kernel@vger.kernel.org
References: <d0bd1c10610170311s3ef77226n1d645f3f1e178753@mail.gmail.com> <d0bd1c10610170318x5dac0620l8842c43430ac33b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d0bd1c10610170318x5dac0620l8842c43430ac33b@mail.gmail.com>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kay Tiong Khoo | 2006-10-17 18:18:25 [+0800]:

>On a timer interrupt, I tried to stop the current process by changing
>it's run state to TASK_STOPPED via set_current_state(TASK_STOPPED).
>However, this results in a system hang.
>
>I can't find a way to stop the current process during an interrupt
>context. Does such code exist in the kernel? If not, how does one go
>about implementing it from within a kernel module.

Take a look at some driver implementations!
There you will find some ways how to put a process into a sleep state.

Grep for "*->state*TASK_UNINTERRUPTIBLE" and take also a look at the
interaction with schedule() and spinlocks.

>Thanks.
>Kay Tiong

Best regards

-- 
Hagen Pfeifer
