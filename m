Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312373AbSCYJNU>; Mon, 25 Mar 2002 04:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312374AbSCYJNJ>; Mon, 25 Mar 2002 04:13:09 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:63493 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S312373AbSCYJMz>; Mon, 25 Mar 2002 04:12:55 -0500
Message-ID: <3C9EE999.4070106@loewe-komp.de>
Date: Mon, 25 Mar 2002 10:10:49 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: James Bourne <jbourne@MtRoyal.AB.CA>,
        Davide Libenzi <davidel@xmailserver.org>,
        David Schwartz <davids@webmaster.com>, joeja@mindspring.com,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: max number of threads on a system
In-Reply-To: <Pine.LNX.4.44.0203220840280.14699-100000@skuld.mtroyal.ab.ca> <Pine.LNX.3.96.1020322221213.24536A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> On Fri, 22 Mar 2002, James Bourne wrote:
> 
> 
>>One thing to note here, using pthreads there is a limit of 1024
>>threads per process.  There are patches to glibc to increase this
>>to a larger number (4096 or 8192).
>>
> 
>   Haven't checked to see the limit in NGPT, but I haven't hit it ;-)
> 

There is another limit creeping in: pthread mmap()s 2 MB
of stack for each thread. So you run out of address space
on 32 bit systems with threads > 1024 (and smaller)





