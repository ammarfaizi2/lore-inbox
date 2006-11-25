Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967232AbWKYVxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967232AbWKYVxy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967233AbWKYVxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:53:54 -0500
Received: from relay.rinet.ru ([195.54.192.35]:35013 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S967232AbWKYVxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:53:53 -0500
Message-ID: <4568BB4F.2070701@mail.ru>
Date: Sun, 26 Nov 2006 00:53:19 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc1-mm1+ memory problem
References: <45614A95.6090102@mail.ru>	<4566F26D.2010404@mail.ru>	<45677B3F.60202@mail.ru> <20061125110331.10f2dd42.akpm@osdl.org>
In-Reply-To: <20061125110331.10f2dd42.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Sun, 26 Nov 2006 00:53:51 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> 89361 times:
>> Page allocated via order 0, mask 0x280d2
>> [0xc0159f31] __handle_mm_fault+1809
>> [0xc011318a] do_page_fault+314
>> [0xc04111c4] error_code+116
>> Can be anything. But if I understand anything, this memory is used 
>> because someone has requested a page that is swapped out. So the memory 
>> must be used, but not reflected in meminfo, and not by a process?

> What you should do is to cause the system to free as many pages as possible
> before looking ad /proc/page_owner.  For example, build `usemem' from
> http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz, run
> 
> 	usemem -m N  (where N is the number of megabytes which the machine has)
> 
> a couple of times.  Then check /proc/meminfo, and look to see which pages
> are left over in /proc/page_owner.

Well, I was too lazy to get this utility, used my own to allocate and 
fill enough memory as to go some 50MB to deep swap (Did I understand 
correctly what usemem does?). Top 3 did not change, except for exact 
numbers.
