Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUHFUXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUHFUXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268264AbUHFUWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:22:19 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:31832 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266155AbUHFUWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:22:07 -0400
Message-ID: <4113E865.3010100@yahoo.com.au>
Date: Sat, 07 Aug 2004 06:21:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <Pine.LNX.4.44.0408052104420.2241-100000@dyn319181.beaverton.ibm.com> <411322E8.4000503@yahoo.com.au> <4113BA65.8050901@lougher.demon.co.uk> <4113D76E.9060906@yahoo.com.au> <4113DE5F.6040801@lougher.demon.co.uk>
In-Reply-To: <4113DE5F.6040801@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:

> page has been found by find_get_page, this is presumably because the
> index is now out of bounds.

Hmm, yeah it looks like that will trigger an out of bounds read. I'm
trying to work out how it can be fixed without doing the i_size check
twice per page - not sure if it is possible. I'll have another look
tomorrow.

> 
> As I said in my previous email, I'm going to put an index
> check into my code.  I don't want this argument to proceed
> and myself to start (?) to look like an ass.
> 

That wasn't what I thought or intended at all. You probably know more
about this code than I do, but even if not you have found a bug or
regression in the code. So let's try to work this one out. So far I
am the only one who looks like an ass because I broke the thing in the
first place :P
