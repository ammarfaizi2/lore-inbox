Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVKHOwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVKHOwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVKHOwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:52:36 -0500
Received: from terminus.zytor.com ([192.83.249.54]:24760 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964894AbVKHOwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:52:35 -0500
Message-ID: <4370BB85.9060303@zytor.com>
Date: Tue, 08 Nov 2005 06:51:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 14/21] i386 Apm is on cpu zero only
References: <200511080433.jA84Xwm7009921@zach-dev.vmware.com> <20051108073315.GE28201@elte.hu>
In-Reply-To: <20051108073315.GE28201@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Zachary Amsden <zach@vmware.com> wrote:
> 
> 
>>APM BIOS code has a protective wrapper that runs it only on CPU zero.  
>>Thus, no need to set APM BIOS segments in the GDT for other CPUs.
> 
> hm, do we want (need) to have that CPU#0 assumption forever?
> 

APM BIOS should only ever run on the BSP, and I believe in Linux the BSP 
is always 0.  Since APM is obsolete, there is no future to consider.

	-hpa
