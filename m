Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVFNNez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVFNNez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 09:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFNNez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 09:34:55 -0400
Received: from [63.81.117.10] ([63.81.117.10]:7410 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261200AbVFNNex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 09:34:53 -0400
Message-ID: <42AEDCFB.8080002@xfs.org>
Date: Tue, 14 Jun 2005 08:34:51 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pozsy@uhulinux.hu, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org>	<20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org>
In-Reply-To: <20050611120040.084942ed.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Jun 2005 13:34:52.0206 (UTC) FILETIME=[D7E814E0:01C570E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Stephen Lord <lord@xfs.org> wrote:
> 
>>Pozsár Balázs wrote:
>> > On Sat, Jun 11, 2005 at 08:23:20AM -0500, Steve Lord wrote:
>> > 
>> >>I think this is not actually module loading itself, but a problem
>> >>between the fork/exec/wait code in nash and the kernel.
>> > 
>> > 
>> > I do not use nash, only bash, so this is not a nash-specific issue.
>> > 
>> > 
>>
>> I disabled hyperthreading and things started working, so are there any
>> HT related scheduling bugs right now?
> 
> 
> There haven't been any scheduler changes for some time.  There have been a
> few low-level SMT changes I think.
> 
> Are you able to identify which kernel version broke it?
> 

Still have not narrowed this down too far, disabling SMT made no
difference, disabling SMP did, which I was expecting.

Steve

