Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWBHKsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWBHKsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWBHKsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:48:11 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:29968 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030279AbWBHKsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:48:10 -0500
Message-ID: <43E9CC63.6070106@argo.co.il>
Date: Wed, 08 Feb 2006 12:48:03 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Raj <inguva@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/pid/maps keeps growing
References: <b2fa632f0602080024r61bf1dbfr8bff6ae6a1860562@mail.gmail.com>
In-Reply-To: <b2fa632f0602080024r61bf1dbfr8bff6ae6a1860562@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2006 10:48:08.0742 (UTC) FILETIME=[261ADC60:01C62C9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raj wrote:

>I have been load testing a server running on RHEL 3.0 (2.4.21). I see that the
>/proc/pid/maps keeps growing.
>
>If the server is leaking memory, then i expected, the heap address to
>change rather than
>creating a new segment. As the server is a threaded app, i tried
>ld_preloading my own
>library to catch all pthread_create calls, but could catch only 4. So
>even threading doesnt
>seem to be an issue.
>
>so i am wondering now. I know the server is leaking memory. But i dont
>know where to look
> at.
>
>Can someone pls help me in letting me know, in which cases can a
>/proc/pid/maps file keep on increasing ?
>
>The server is running on IBM hardware, with 4GB ram. The maps file
>currently has 2200
>lines just like the ones pasted below.
>
>  
>
malloc() and friends can use mmap() to allocate memory, usually for 
larger allocations. looks like you have a leak.

-- 
error compiling committee.c: too many arguments to function

