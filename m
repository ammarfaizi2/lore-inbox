Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVBWJaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVBWJaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 04:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVBWJaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 04:30:16 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:19635 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261438AbVBWJaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 04:30:09 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: kaigai@ak.jp.nec.com, jlan@sgi.com,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com, elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050223005135.3d8ce2f3.akpm@osdl.org>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>
	 <20050222232002.4d934465.akpm@osdl.org>
	 <1109147623.1738.91.camel@frecb000711.frec.bull.fr>
	 <20050223005135.3d8ce2f3.akpm@osdl.org>
Date: Wed, 23 Feb 2005 10:30:06 +0100
Message-Id: <1109151006.1738.119.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 10:39:00,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 10:39:02,
	Serialize complete at 23/02/2005 10:39:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 00:51 -0800, Andrew Morton wrote:
> > It's what I'm proposing. The problem is to be alerted when a new process
> > is created in order to add it in the correct group of processes if the
> > parent belongs to one (or several) groups. The notification can be done
> > with the fork connector patch. 
> 
> Yes, it sounds sane.
> 
> The 2.6.8.1 ELSA patch adds quite a bit of kernel code, but from what
> you're saying it seems like most of that has become redundant, and all
> you now need is the fork notifier.  Is that correct?

  Yes, that's correct. All I need is the fork connector patch. It needs
more work like, as you said, sending an on/off message down the netlink
socket. I'm working on this (thank you very much Andrew for your
comments).

  I will run benchmarks found at http://bulk.fefe.de/scalability/ to see
how the fork connector impacts on the kernel.

  All stuff that was previously done in kernel space and provided by the
2.6.8.1 ELSA patch has been moved in the ELSA user space daemon called
"jobd".

Best,
Guillaume

