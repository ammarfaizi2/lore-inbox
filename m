Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266899AbTGHHnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 03:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbTGHHnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 03:43:45 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:34251 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S266899AbTGHHno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 03:43:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Davide Libenzi <davidel@xmailserver.org>, Szonyi Calin <sony@etc.utt.ro>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Tue, 8 Jul 2003 17:59:39 +1000
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200307070317.11246.kernel@kolivas.org> <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro> <Pine.LNX.4.55.0307080007200.3648@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307080007200.3648@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307081759.39215.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 17:46, Davide Libenzi wrote:
> On Tue, 8 Jul 2003, Szonyi Calin wrote:
> > In the weekend i did some experiments with the defines in kernel/sched.c
> > It seems that changing in MAX_TIMESLICE the "200" to "100" or even "50"
> > helps a little bit. (i was able to do a make bzImage and watch a movie
> > without noticing that is a kernel compile in background)
>
> I bet it helps. Something around 100-120 should be fine. Now we need an
> exponential function of the priority to assign timeslices to try to
> maintain interactivity. This should work :

This is still decreasing the timeslices. Whether you do it linearly or 
exponentially the timeslices are smaller, which just about everyone will 
resist you doing.

Con

