Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVKOQNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVKOQNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVKOQNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:13:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751036AbVKOQN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:13:29 -0500
Date: Tue, 15 Nov 2005 08:12:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gerd Knorr <kraxel@suse.de>
cc: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <437A0649.7010702@suse.de>
Message-ID: <Pine.LNX.4.64.0511150808430.3125@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com>
 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com>
 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>
 <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
 <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Nov 2005, Gerd Knorr wrote:
> 
> i.e. something like this (as basic idea, patch is far away from doing anything
> useful ...)?

Can't work. The altinstructions are in init-code/data, and will be free'd 
after boot. Which is as it should be. But it means that any setup that 
expects to use them to switch back and forth is broken (not that your 
patch does so now, but if that's what you are moving toward..)

		Linus
