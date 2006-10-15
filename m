Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWJOUCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWJOUCn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 16:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWJOUCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 16:02:43 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:57761 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932145AbWJOUCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 16:02:42 -0400
Date: Sun, 15 Oct 2006 22:02:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: privilege levels and kernel mode
In-Reply-To: <20061015191716.15283.qmail@web27401.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61.0610152200440.13483@yvahk01.tjqt.qr>
References: <20061015191716.15283.qmail@web27401.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>    I am using pentium-4 processor. My operating
>system  is Linux version 2.4.22-1.2199.nptl
>
>  I want to measure performance events like number of
>memory reads, number of cache misses occured while
>running  a "C" program. For that I have to wright some
>values into "Model specific registers of pentium-4
>processor". But those registers can be written ONLY at
>privilege level of zero of pentium4 processor.
>
> We know that application programs we write (for
>example any C program)are run at privilege
>level-3(user mode).
>
>I know how to include assembly instructions in a C
>program to wtrite into "Model specific registers". But
>that program has to be run at privilege level zero.
>
>How to run a C program at privilege level zero??

The short answer: You can't.

The long answer: You have to write a kernel module to do what you need.

The best answer: Use /dev/cpu/0/msr.

>Can any one help me?
>
>Thanks in advance.
>
> 
>
>Send instant messages to your online friends http://uk.messenger.yahoo.com 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

	-`J'
-- 
