Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVBYF3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVBYF3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 00:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVBYF3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 00:29:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:18312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262544AbVBYF3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 00:29:41 -0500
Date: Thu, 24 Feb 2005 21:28:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: jlan@sgi.com, lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050224212839.7953167c.akpm@osdl.org>
In-Reply-To: <421EB299.4010906@ak.jp.nec.com>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
	<421CEC38.7010008@sgi.com>
	<421EB299.4010906@ak.jp.nec.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
>
> In my understanding, what Andrew Morton said is "If target functionality can
>  implement in user space only, then we should not modify the kernel-tree".

fork, exec and exit upcalls sound pretty good to me.  As long as

a) they use the same common machinery and

b) they are next-to-zero cost if something is listening on the netlink
   socket but no accounting daemon is running.

Question is: is this sufficient for CSA?
