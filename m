Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVBBHu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVBBHu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVBBHu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:50:27 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:53210 "HELO
	ns.intellilink.co.jp") by vger.kernel.org with SMTP id S261946AbVBBHuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:50:21 -0500
Message-ID: <4200861B.7040807@intellilink.co.jp>
Date: Wed, 02 Feb 2005 16:49:47 +0900
From: Koichi Suzuki <koichi@intellilink.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Itsuro Oda <oda@valinux.co.jp>
Cc: ebiederm@xmission.com, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <1107271039.15652.839.camel@2fwv946.in.ibm.com> <m13bwgb8tb.fsf@ebiederm.dsl.xmission.com> <20050202154926.18D4.ODA@valinux.co.jp>
In-Reply-To: <20050202154926.18D4.ODA@valinux.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda wrote:
> Hi,
> 
> I can't understand why ELF format is necessary.
> 
> I think the only necessary information is "what physical address 
> regions are valid to read". This information is necessary for any
> sort of dump tools. (and must get it while the system is normal.)
> The Eric's /proc/cpumem idea sounds nice to me. 
> 

I agree.  Format conversion should be done in healthy system separately 
and we should restrict what to do while taking the dump as few as 
possible.  Conversion from just memory image to crash/lcrash format will 
be very useful to use existing tools and experiences.   I already have 
such tool and (if my administration allows) I can make such tool open. 
Let me do some paperwork.

Koichi Suzuki
NTT DATA Intellilink
