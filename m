Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264529AbUDTWYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264529AbUDTWYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUDTWVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:21:16 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:43694 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264581AbUDTV4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:56:24 -0400
Subject: Re: [module-init-tools] Segmentation fault
From: Rusty Russell <rusty@rustcorp.com.au>
To: =?ISO-8859-1?Q?M=E9her?= Khiari <meher@wanadoo.fr>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4083A05F.8060309@wanadoo.fr>
References: <4083A05F.8060309@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1082444781.5566.166.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Apr 2004 07:56:02 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-19 at 19:48, Méher Khiari wrote:
> Hi all
> It is my first post here.
> I didn't find any other mailing list talking about module-init-tools 
> (nor a wiki page), so I am posting here.
> I got module-init-tools-0.9.14, I compiled and installed (as written in 
> the README) but I got a segmentation fault when I tested modprobe.
> Although, I got the testsuite and ran the test and all went well !!!!

Yes.  The testsuite rebuilds the binaries with -DJUST_TESTING so it can
do nasty things to the internals (like control uname).  These will
segfault if run normally.  Hence "make check" now does a "make clean" at
the end.

Hope that helps!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

