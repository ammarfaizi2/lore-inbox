Return-Path: <linux-kernel-owner+w=401wt.eu-S1753027AbWLQR1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbWLQR1O (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbWLQR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 12:27:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45649 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024AbWLQR1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 12:27:13 -0500
Date: Sun, 17 Dec 2006 09:26:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
In-Reply-To: <20061217131033.GA25999@tomodachi.de>
Message-ID: <Pine.LNX.4.64.0612170925440.3479@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
 <Pine.LNX.4.64.0612160955370.3557@woody.osdl.org>
 <20061216225338.GA2616@melchior.yamamaya.is-a-geek.org>
 <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
 <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
 <20061216235513.GA2424@melchior.yamamaya.is-a-geek.org>
 <Pine.LNX.4.64.0612161603070.3479@woody.osdl.org> <20061217131033.GA25999@tomodachi.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Tobias Diedrich wrote:
> 
> BTW, I'm also wondering if this secondary Oops is supposed to happen:

Well, if the timer doesn't work, then the NMI watchdog will trigger. So 
it's "supposed" to happen in the sense that yeah, it's kind of expected, 
but it's really bsically just a secondary issue. If the timer worked 
properly, you'd never see it. 

So it's just fallout from the original problem you have, and not 
interesting in itself.

		Linus
