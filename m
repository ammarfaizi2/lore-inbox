Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVCIG0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVCIG0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVCIG0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:26:18 -0500
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:63320 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262171AbVCIGZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:25:59 -0500
Message-ID: <422E96D9.6090202@yahoo.com>
Date: Tue, 08 Mar 2005 22:25:29 -0800
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
References: <422BFCB2.6080309@yahoo.com> <20050309050434.GT3163@waste.org> <422E8EEB.7090209@yahoo.com> <20050309060544.GW3120@waste.org>
In-Reply-To: <20050309060544.GW3120@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>On Tue, Mar 08, 2005 at 09:51:39PM -0800, Alex Aizman wrote:
>  
>
>>Matt Mackall wrote:
>>
>>    
>>
>>>How big is the userspace client?
>>>
>>>      
>>>
>>Hmm.. x86 executable? source?
>>
>>Anyway, there's about 12,000 lines of user space code, and growing. In 
>>the kernel we have approx. 3,300 lines.
>>
>>    
>>
>>>>- 450MB/sec Read on a single connection (2-way 2.4Ghz Opteron, 64KB block 
>>>>size);
>>>>        
>>>>
>>>With what network hardware and drives, please?
>>>
>>>      
>>>
>>Neterion's 10GbE adapters. RAM disk on the target side.
>>    
>>
>
>Ahh.
>
>Snipped my question about userspace deadlocks - that was the important
>one. It is in fact why the sfnet one is written as it is - it
>originally had a userspace component and turned out to be easy to
>deadlock under load because of it.
>
>  
>
There's (or at least was up until today) an ongoing discussion on our 
mailing list at http://groups-beta.google.com/group/open-iscsi. The 
short and long of it: the problem can be solved, and it will. Couple 
simple things we already do: mlockall() to keep the daemon un-swapped, 
and also looking into potential dependency created by syslog (there's 
one for 2.4 kernel, not sure if this is an issue for 2.6).

The sfnet is a learning experience; it is by no means a proof that it 
cannot be done.

Alex
