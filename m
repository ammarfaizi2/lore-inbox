Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVKWVzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVKWVzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVKWVzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:55:00 -0500
Received: from terminus.zytor.com ([192.83.249.54]:23191 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932549AbVKWVy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:54:59 -0500
Message-ID: <4384E4F7.9060806@zytor.com>
Date: Wed, 23 Nov 2005 13:53:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org>
In-Reply-To: <20051123214835.GA24044@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> I don't think I see the point.  This would let you optimize for the
> "multi-threaded, but hasn't created any threads yet" or even
> "multi-threaded, but not right now" cases.  But those really aren't the
> interesting case to optimize for - that's the equivalent of supporting
> CPU hotplug.
> 
> The interesting case is when you know at static link time that the
> library is single-threaded, or even at dynamic link time.  And it's
> easy enough at both of those times to handle this.  In many cases glibc
> doesn't, because it's valid to dlopen libpthread.so, but that could be
> accomodated - a simple matter of software.
> 

No, you can never know that unless you can't call mmap().

	-hpa
