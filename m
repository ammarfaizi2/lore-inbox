Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUFRAmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUFRAmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUFRAmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:42:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264891AbUFRAm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:42:29 -0400
Date: Thu, 17 Jun 2004 20:42:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Ben Greear <greearb@candelatech.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll
In-Reply-To: <Pine.LNX.4.58.0406171726000.24496@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.53.0406172041150.3581@chaos>
References: <Pine.LNX.4.53.0406170954190.702@chaos> <40D21C8E.4040500@candelatech.com>
 <Pine.LNX.4.53.0406171958570.3414@chaos> <Pine.LNX.4.58.0406171726000.24496@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Davide Libenzi wrote:

> On Thu, 17 Jun 2004, Richard B. Johnson wrote:
>
> > This all works fine-and-dandy with kernel 2.4.26. However, Linux
> > has a history of removing availability of undefined things.
>
> It'd work just fine in 2.6. The poll infrastructure is just a proxy to the
> event core, and shouldn't mask anything. Your driver's f_op->poll will
> return a mask, and this will be and'ed with the mask that you pass to poll(2).
> Non-zero results will be reported to you. Just do not use bits 30 and 31
> if you want it to work with epoll.
>
> - Davide
>

Thanks. That's what I wanted to hear.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


