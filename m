Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWEOWxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWEOWxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWEOWxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:53:03 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:57775 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750715AbWEOWxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:53:00 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Segfault on the i386 enter instruction
Date: Tue, 16 May 2006 00:49:48 +0200
User-Agent: KMail/1.9.1
Cc: Stas Sergeev <stsp@aknet.ru>, Andi Kleen <ak@muc.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <44676F42.7080907@aknet.ru> <4468D8CA.6070702@aknet.ru> <1147722991.13948.19.camel@mindpipe>
In-Reply-To: <1147722991.13948.19.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605160049.49384.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Monday, 15. May 2006 21:56, Lee Revell wrote:
> Just FYI, this does actually have an important effect on multithreaded
> programs - glibc will allocate RLIMIT_STACK for each thread stack.  If
> mlockall() is used this can eat quite a bit of memory.  It's a real
> world problem for some pro audio apps.

If it is: pthread_attr_setstacksize() is your friend.
If you like to use the big hammer: just lower RLIMIT_STACK.

So no unsolvable real world problem here :-)


Regards

Ingo Oeser
