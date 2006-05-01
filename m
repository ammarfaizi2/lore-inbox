Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWEAHyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWEAHyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWEAHyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:54:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751318AbWEAHyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:54:31 -0400
Date: Mon, 1 May 2006 00:49:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-Id: <20060501004925.36e4dd21.akpm@osdl.org>
In-Reply-To: <1146469146.20760.31.camel@laptopd505.fenrus.org>
References: <20060501071134.GH3570@stusta.de>
	<20060501001803.48ac34df.akpm@osdl.org>
	<20060501073514.GQ3570@stusta.de>
	<1146469146.20760.31.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> > If removing exports requires a process, adding exports requires a 
>  > similar process.
> 
>  alternatively we should bite the bullet, and just stick those 900 on the
>  "we'll kill all these in 3 months" list, have a thing to disable them
>  now via a config option (so that people actually notice rather than just
>  having them in the depreciation file) and fix the 5 or 10 or so that
>  actually will be used soon in those 3 months.
> 

I'd instead suggest that we implement a new EXPORT_SYMBOL_UNEXPORT_SCHEDULED
(?) and use that.  Suitable compile-time and modprobe-time warnings would
be needed.  Put the unexport date in a comment at the
EXPORT_SYMBOL_UNEXPORT_SCHEDULED site or even in the modprobe-time warning
message, if that's convenient:

EXPORT_SYMBOL_UNEXPORT_SCHEDULED(foo, "Dec 2006");


