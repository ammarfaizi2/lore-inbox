Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUACS6O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUACS5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:57:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32274 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263788AbUACS5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:57:38 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [CFT][RFC] HT scheduler
Date: Sat, 03 Jan 2004 13:57:45 -0500
Organization: TMR Associates, Inc
Message-ID: <bt72kk$chk$1@gatekeeper.tmr.com>
References: Your message of "Sat, 13 Dec 2003 17:43:35 +1100."             <3FDAB517.4000309@cyberone.com.au> <20031215060838.BF3D32C257@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073155540 12852 192.168.12.10 (3 Jan 2004 18:45:40 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20031215060838.BF3D32C257@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Actually, having produced the patch, I've changed my mind.
> 
> While it was spiritually rewarding to separate "struct runqueue" into
> the stuff which was to do with the runqueue, and the stuff which was
> per-cpu but there because it was convenient, I'm not sure the churn is
> worthwhile since we will want the rest of your stuff anyway.
> 
> It (and lots of other things) might become worthwhile if single
> processors with HT become the de-facto standard.  For these, lots of
> our assumptions about CONFIG_SMP, such as the desirability of per-cpu
> data, become bogus.

Now that Intel is shipping inexpensive CPUs with HT and faster memory 
bus, I think that's the direction of the mass market. It would be very 
desirable to have HT help rather than hinder. However, I admit I'm 
willing to take the 1-2% penalty on light load to get the bonus on heavy 
load.

If someone has measured the effect of HT on interrupt latency or server 
transaction response I haven't seen it, but based on a server I just 
built using WBEL and the RHEL scheduler, first numbers look as if the 
response is better. This is just based on notably less data in the 
incoming sockets, but it's encouraging.

"netstat -t | sort +1nr" shows a LOT fewer sockets with unread bytes.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
