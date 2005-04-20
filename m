Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVDTOPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVDTOPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 10:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVDTOPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 10:15:31 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:16045 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261638AbVDTOPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 10:15:25 -0400
Message-ID: <426663E8.3080502@jp.fujitsu.com>
Date: Wed, 20 Apr 2005 23:15:04 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       hari@in.ibm.com
Subject: Re: [RFC][PATCH] nameing reserved pages [0/3]
References: <426644DA.70105@jp.fujitsu.com> <1114000447.6238.64.camel@laptopd505.fenrus.org>
In-Reply-To: <1114000447.6238.64.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>For example, Memory Hotplug can ignore (a).
>>    
>>
>
>Memory Hotplug can also use page_is_ram().
>  
>
Yes. we can use page_is_ram() for finding (a)memory hole.
But I'd like to catch other removable PG_reserved pages like (d)Isorated 
by MCA (e)used by perfmon and
some of (b) used by kernerl and (c) Set by drivers.
What I'm thinking of is to detect whether memory is hot-removable or not 
before removing actually.

>/dev/memstate really looks like a bad idea to me as well... I rather
>have less than more /dev/*mem*
>  
>
For showing page usage and its "location", I've thought of other 
interface, sysfs, procfs...
But I have no idea.
Physical memory area has vast space and I want to use lseek() or 
ioctl().( I don't like  ioctl())
Do you have any recommendation ?

-- Kame


