Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTLWCkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTLWCkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:40:53 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:1256 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264433AbTLWCkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:40:46 -0500
Message-ID: <3FE7AB29.7030502@cyberone.com.au>
Date: Tue, 23 Dec 2003 13:40:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
References: <7F740D512C7C1046AB53446D372001736187E4@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D372001736187E4@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nakajima, Jun wrote:

>Today utilization of execution resources of a logical processor is
>around 60% as you can find in public papers, and it's dependent on the
>processor implementation and the workload. It could be higher in the
>future, and their relative priority could be much higher then. So I
>don't think it's a good idea to hard code such a implementation-specific
>factor into the generic scheduler code.
>

No. The mechanism would be generic, but the parameters would be
arch specific as part of my sched domains patch (if I have anything
to do with it!)

>
>Regarding H/W-based priority, I'm not sure it's very useful especially
>because so many events happen inside the processor and a set of the
>execution resources required changes very rapidly at runtime, i.e. the
>H/W knows what it should do to run faster at runtime, and imposing
>priority on those logical processor could make them run slower.
>
>I think a software priority-based solution like the below would be more
>generic and work better.
>

I wouldn't pretend to know about hardware, but it seems like much nicer
than doing it in software. Anyway, if there is hardware out there without
priorities then it would be a good idea to code for it.

Nick

