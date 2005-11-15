Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVKOQEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVKOQEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVKOQEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:04:35 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:9988 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751442AbVKOQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:04:34 -0500
Message-ID: <437A0710.4020107@vmware.com>
Date: Tue, 15 Nov 2005 08:04:32 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>
In-Reply-To: <437A0649.7010702@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2005 16:04:33.0733 (UTC) FILETIME=[44EDD750:01C5E9FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

>> Yep, extending alternatives is probably better than duplicating the 
>> code.  Maybe having some alternative_smp() macro which places both 
>> code versions into the .altinstr_replacement table?  If that sounds 
>> ok I'll try to come up with a experimental patch.
>
>
> i.e. something like this (as basic idea, patch is far away from doing 
> anything useful ...)?


You still need to preserve the originals so that you can patch in both 
directions.  In the dynamic scenario, you need a multi-way set of 
alternatives, with the most conservative of those compiled in inline.

Zach
