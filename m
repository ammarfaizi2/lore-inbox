Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUBAAVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 19:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUBAAVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 19:21:07 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:19124 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S264565AbUBAAVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 19:21:03 -0500
Message-Id: <5.1.0.14.2.20040201110919.04788eb0@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 01 Feb 2004 11:20:50 +1100
To: JG <jg@cms.ac>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TG3: very high CPU usage
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040131091559.8A026202D31@23.cms.ac>
References: <20040125123154.A8CA4202CAA@23.cms.ac>
 <20040122125516.7B671202CDC@23.cms.ac>
 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
 <20040119033527.GA11493@linux.comp>
 <20040119033527.GA11493@linux.comp>
 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
 <5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
 <20040122125516.7B671202CDC@23.cms.ac>
 <5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
 <20040125123154.A8CA4202CAA@23.cms.ac>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:15 PM 31/01/2004, JG wrote:
>well, i did a thorough cable test with a DSP-4100 fluke networks cable 
>tester and i had some bad values. i've been using 3 cables (24m) with 
>adapters, all single cables were fine, so the adapters seemed to cause the 
>problem.
>but i'm now using a longer x-over cable (30m) where i also get those speed 
>problems. it is a *bit* better, i get about 1-2MB/s in both directions, 
>but i'm also experiencing a very high error rate over the x-over 
>cable...(~40-50 errors per second)

if you get ANY errors, then its bad; even 1 error per second basically 
means "one lost packet per second", which will severly limit your TCP 
throughput.

one thing you may want to do to is drop the link to 100mbit/s rather than 
gig-e; that will use less cable pairs and may avoid the problem.
100mbit/s without errors will likely be way way faster than 1000mbit/s with 
50 errors/sec.

>do you have this BACS software and is it possible to test the NIC itself 
>with it? maybe one of my NICs is causing this.

it seems there is only a Windows version of their diagnostics.
personally, i use IBM xSeries servers.  their version of the BACS code is 
at <http://www-306.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-43815>.
i've seen other servers (e.g. Compaq DL360?) that also use the BCM57xx; 
their BACS tool is rebadged as being a HP tool.


cheers,

lincoln.


>thx,
>JG
>

