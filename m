Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264537AbUEJIZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUEJIZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 04:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUEJIZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 04:25:43 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:51462 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264560AbUEJIZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 04:25:42 -0400
Message-ID: <409F3CEE.8060102@aitel.hist.no>
Date: Mon, 10 May 2004 10:27:26 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
References: <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <20040508135512.15f2bfec.akpm@osdl.org> <20040508211920.GD4007@in.ibm.com> <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org> <20040508201215.24f0d239.davem@redhat.com> <Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org> <20040509210312.GL5414@waste.org>
In-Reply-To: <20040509210312.GL5414@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>One also wonders about whether all the RCU stuff is needed on UP. I'm
>not sure if I grok all the finepoints here, but it looks like the
>answer is no and that we can make struct_rcu head empty and have
>call_rcu fall directly through to the callback. This would save
>something like 16-32 bytes (32/64bit), not to mention a bunch of
>dinking around with lists and whatnot.
>
>So what am I missing?
>  
>
Preempt can happen anytime, I believe.

Helge Hafting
