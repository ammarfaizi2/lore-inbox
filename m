Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUCEW6G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUCEW6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:58:05 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:39148 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261413AbUCEW6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:58:01 -0500
Message-ID: <404905E1.70709@matchmail.com>
Date: Fri, 05 Mar 2004 14:57:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Kyle Wong <kylewong@southa.com>, linux-kernel@vger.kernel.org
Subject: Re: questions about io scheduler
References: <088201c40293$5b27ce80$9c02a8c0@southa.com> <40484643.7070104@cyberone.com.au>
In-Reply-To: <40484643.7070104@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Kyle Wong wrote:
>> 2. Does io scheduler works with md RAID? Correct me if I'm wrong,
>> io-schedular <-->  md driver <--> harddisks.
>>
>>
> 
> It goes md driver -> io schedulers -> hard disks.

There is an IO scheduler per disk.

So MD submits the data to each disk through the IO scheduler.

This allows you to have the heads on each disk in the array at different 
locations, and helps keep response times lower for seeky loads.
