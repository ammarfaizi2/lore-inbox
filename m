Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUDOMCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 08:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUDOMCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 08:02:19 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:31884 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262499AbUDOMCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 08:02:17 -0400
Date: Thu, 15 Apr 2004 14:03:58 +0200 (CEST)
From: Simon Derr <simon.derr@bull.net>
X-X-Sender: derr@daphne.frec.bull.fr
To: =?iso-8859-1?q?alan=20pearson?= <alandpearson@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sched_getaffinity & sched_setaffinity returning -1 (errstr =
 Bad address)
In-Reply-To: <20040415105424.19946.qmail@web11411.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0404151358160.7864@daphne.frec.bull.fr>
References: <20040415105424.19946.qmail@web11411.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Apr 2004, alan pearson wrote:

> Hi
>
> I've been trying to use the sched_getaffinity &
> sched_setaffinity on
> kernel 2.6.4 and it is working on some systems and not
> others !
> It works fine on my aged dual CPU pentium pro box, but
> on the box I
> really want it to work on, the calls return -1 !

My guess is that on your newer box you also have a newer Linux
distribution with the new sched_setaffinity() prototype, e.g with only two
parameters.

new libc sched.h:
extern int sched_setaffinity (__pid_t __pid, __const cpu_set_t *__mask);

	Simon.

