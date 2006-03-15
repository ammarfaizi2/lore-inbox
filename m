Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWCOUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWCOUAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 15:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWCOUAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 15:00:41 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:9618 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750916AbWCOUAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 15:00:41 -0500
In-Reply-To: <1142452665.3021.43.camel@laptopd505.fenrus.org>
References: <20060315193114.GA7465@in.ibm.com> <1142452665.3021.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C6CFDF8E-CE60-4FCD-AC17-72DC83E8521C@kernel.crashing.org>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Date: Wed, 15 Mar 2006 14:01:13 -0600
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 15, 2006, at 1:57 PM, Arjan van de Ven wrote:

>
>> One of the possible solutions to this problem is that expand the size
>> of "start" and "end" to "unsigned long long". But whole of the PCI  
>> and
>> driver code has been written assuming start and end to be unsigned  
>> long
>> and compiler starts throwing warnings.
>
>
> please use dma_addr_t then instead of unsigned long long
>
> this is the right size on all platforms afaik (could a ppc64 person
> verify this?> ;)

Actually we really just want "start" and "end" to be u64 on all  
platforms.  Linus was ok with this change but no one has gone through  
and fixed everything that would be required for it.

- kumar
