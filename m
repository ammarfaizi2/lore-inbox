Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVKOQ14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVKOQ14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVKOQ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:27:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:60112 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964859AbVKOQ1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:27:55 -0500
Message-ID: <437A0C88.50207@suse.de>
Date: Tue, 15 Nov 2005 17:27:52 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <Pine.LNX.4.64.0511150808430.3125@g5.osdl.org> <20051115161656.GB1749@redhat.com>
In-Reply-To: <20051115161656.GB1749@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Nov 15, 2005 at 08:12:36AM -0800, Linus Torvalds wrote:
> 
>  > On Tue, 15 Nov 2005, Gerd Knorr wrote:
>  > > i.e. something like this (as basic idea, patch is far away from doing anything
>  > > useful ...)?
>  > 
>  > Can't work. The altinstructions are in init-code/data, and will be free'd 
>  > after boot. Which is as it should be. 

Good point, so better place the ones we need at runtime into a separate 
table ...

> Hmmm, what about modules ?

We'll need some new fields in struct module ...

Is already on the list in my head, but I didn't bother yet for that 
proof-of-concept discussion patch ;)

   Gerd
