Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUEDLkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUEDLkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 07:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUEDLkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 07:40:13 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:26543 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264278AbUEDLkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 07:40:09 -0400
Message-ID: <40978108.3020600@yahoo.com.au>
Date: Tue, 04 May 2004 21:39:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: peter@mysql.com, linuxram@us.ibm.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
References: <200405022357.59415.alexeyk@mysql.com>	<409629A5.8070201@yahoo.com.au>	<20040503110854.5abcdc7e.akpm@osdl.org>	<1083615727.7949.40.camel@localhost.localdomain>	<20040503135719.423ded06.akpm@osdl.org>	<1083620245.23042.107.camel@abyss.local>	<20040503145922.5a7dee73.akpm@osdl.org>	<4096DC89.5020300@yahoo.com.au>	<20040503171005.1e63a745.akpm@osdl.org>	<4096E1A6.2010506@yahoo.com.au> <20040503181533.59af9762.akpm@osdl.org>
In-Reply-To: <20040503181533.59af9762.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> 
> Sorry, I do not understand that paragraph at all.
> 
> All forms or pagecache population need to examine the pagecache to find out
> if the page is already there.  This involves pagecache lookups.  We want
> the read code to "learn" that the requested pages are all coming from cache
> and to stop doing those lookups altogether.

Yeah I think I have an idea of what the basic problems are,
but I'd have to understand things better before I know if I
am really on the right track.

My idea would probably also involve redoing some of the code
code too, so at the moment I don't think I have time. If your
simple fix works though, then that sounds good.
