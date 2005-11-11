Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKKLPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKKLPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVKKLPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:15:06 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:53262 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750762AbVKKLPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:15:05 -0500
Message-ID: <43747D33.3000706@argo.co.il>
Date: Fri, 11 Nov 2005 13:14:59 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local denial-of-service with file leases
References: <43737CBE.2030005@argo.co.il> <20051111084554.GZ7991@shell0.pdx.osdl.net> <43746CF2.5000501@argo.co.il>
In-Reply-To: <43746CF2.5000501@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2005 11:15:03.0091 (UTC) FILETIME=[29913830:01C5E6B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:

>>
>> I don't have a good mechanism for testing leases, but this should fix
>> the leak.  Mind testing?
>>
>>  
>>
> the test program of course passes, but now samba hangs when reading a 
> file (mount -t cifs from the same machine). 2.6.14.1 reads the file 
> but leaks memory.
>

Sorry, it doesn't hang, it's just very slow (3Mbit/sec over loopback), 
but that's not because of the leases AFAICT.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

