Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUHCG77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUHCG77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUHCG5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:57:54 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:31134 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265106AbUHCG5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:57:30 -0400
Message-ID: <410F36C7.5060103@yahoo.com.au>
Date: Tue, 03 Aug 2004 16:55:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, marcelo.tosatti@cyclades.com,
       kladit@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
References: <20040726150615.GA1119@xeon2.local.here>	<20040729140743.170acb3e.akpm@osdl.org>	<20040730163007.GA2931@logos.cnet>	<20040730124744.0eb11f63.akpm@osdl.org>	<Pine.LNX.4.58.0407311003210.16847@ppc970.osdl.org> <20040731143925.014ce12a.akpm@osdl.org>
In-Reply-To: <20040731143925.014ce12a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>> Something like this (totally untested, may not compile, you get the idea) 
>> might work. Or not. Since the _rest_ of "shrink_slab()" doesn't know about 
>> zonelists, just making the "how many pages does this zone have free" take 
>> the zonelist into account might cause other problems.
> 
> 
> No, I think it'll be OK.  Problems in this area tend to be subtle, and take
> time to appear.  But I think this one is pretty safe.
> 

Yeah it is better than what we had before. It now has failure cases
going the other way, but I like this for a non intrusive fix.
