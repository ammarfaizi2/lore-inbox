Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbTEURrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 13:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbTEURrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 13:47:41 -0400
Received: from palrel13.hp.com ([156.153.255.238]:64218 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262222AbTEURnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 13:43:18 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16075.48579.189593.405154@napali.hpl.hp.com>
Date: Wed, 21 May 2003 10:56:19 -0700
To: Mike Galbraith <efault@gmx.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: web page on O(1) scheduler
In-Reply-To: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
References: <16075.8557.309002.866895@napali.hpl.hp.com>
	<5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 21 May 2003 11:26:31 +0200, Mike Galbraith <efault@gmx.de> said:

  Mike> The page mentions persistent starvation.  My own explorations
  Mike> of this issue indicate that the primary source is always
  Mike> selecting the highest priority queue.

My working assumption is that the problem is a bug with the dynamic
prioritization.  The task receiving the signals calls sleep() after
handling a signal and hence it's dynamic priority should end up higher
than the priority of the task sending signals (since the sender never
relinquishes the CPU voluntarily).

However, I haven't actually had time to look at the relevant code, so
I may be missing something.  If you understand the issue better,
please explain to me why this isn't a dynamic priority issue.

	--david
