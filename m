Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWJLSUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWJLSUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWJLSUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:20:21 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:56027 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750743AbWJLSUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:20:19 -0400
Message-ID: <452E876F.1000604@cfl.rr.com>
Date: Thu, 12 Oct 2006 14:20:31 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net>
In-Reply-To: <452E62F8.5010402@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2006 18:20:32.0700 (UTC) FILETIME=[1AC8A7C0:01C6EE2B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14746.003
X-TM-AS-Result: No--10.041900-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> Can context switches be made faster?  This is a simple question, mainly
> because I don't really understand what happens during a context switch
> that the kernel has control over (besides storing registers).
> 

Besides saving the registers, the expensive operation in a context 
switch involves flushing caches and switching page tables.  This can be 
avoided if the new and old processes both share the same address space.


