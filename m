Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVBXSU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVBXSU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVBXSU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:20:26 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39308 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262445AbVBXSUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:20:10 -0500
Message-ID: <421E1AC1.1020901@nortel.com>
Date: Thu, 24 Feb 2005 12:19:45 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chad N. Tindel" <chad@tindel.net>
CC: Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com>
In-Reply-To: <20050224175331.GA18723@calma.pair.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad N. Tindel wrote:

> 1.  Kernel preempts all.  There may be some hierarchy of kernel priorities
> too, but it isn't important here.
> 2.  SCHED_FIFO processes preempt all userspace applications.
> 3.  SCHED_RR.
> 4.  SCHED_OTHER.
> 
> Under no circumstances should any single CPU-bound userspace thread completely 
> hose a 64-way SMP box.
> 
> Can somebody educate me on why it is correct to do it any other way?

Low-latency userspace apps.  The audio guys, for instance, are trying to 
get latencies down to the 100us range.

If random kernel threads can preempt userspace at any time, they wreak 
havoc with latency as seen by userspace.

Chris
