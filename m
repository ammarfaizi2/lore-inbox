Return-Path: <linux-kernel-owner+w=401wt.eu-S1754932AbWL1TBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbWL1TBL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbWL1TBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:01:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51421 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932AbWL1TBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:01:09 -0500
Date: Thu, 28 Dec 2006 11:00:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <20061228180536.GB7385@torres.zugschlus.de>
Message-ID: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au>
 <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
 <20061228180536.GB7385@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Marc Haber wrote:
> 
> After being up for ten days, I have now encountered the file
> corruption of pkgcache.bin for the first time again. The 256 MB i386
> box is like 26M in swap, is under very moderate load.
> 
> I am running plain vanilla 2.6.19.1. Is there a patch that I should
> apply against 2.6.19.1 that would help in debugging?

Not right now. 

And I have a test-program that shows the corruption _much_ easier (at 
least according to my own testing, and that of several reporters that back 
me up), and that seems to show the corruption going way way back (ie going 
back to Linux-2.6.5 at least, according to one tester).

So it just got a lot _easier_ to trigger in 2.6.19, but it's not a new 
bug.

What we need now is actually looking at the source code, and people who 
understand the VM, I'm afraid. I'm gathering traces now that I have a good 
test-case. I'll post my trace tools once I've tested that they work, in 
case others want to help.

(And hey, you don't have to be a VM expert to help: this could be a 
learning experience. However, I'll warn you: this is _the_ most grotty 
part of the whole kernel. It's not even ugly, it's just damn hard and 
complex).

		Linus
