Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTDXSb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTDXSb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:31:59 -0400
Received: from watch.techsource.com ([209.208.48.130]:3831 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263788AbTDXSb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:31:58 -0400
Message-ID: <3EA83447.1090808@techsource.com>
Date: Thu, 24 Apr 2003 15:00:23 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: root@chaos.analogic.com, Chuck Ebbert <76306.1226@compuserve.com>,
       Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
References: <200304241128_MC3-1-35DA-F3DA@compuserve.com> <Pine.LNX.4.53.0304241147420.32073@chaos> <3EA8114A.4020309@techsource.com> <Pine.LNX.4.53.0304241244430.32333@chaos> <3EA81BBB.3020709@techsource.com> <20030424182756.GA19290@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Willy Tarreau wrote:

>Hi !
>
>Well, although I usually don't like these endless coding-style threads, why
>don't you simply use this common form ? :
>
>    return !!(foo & MASK);
>
>I found that the compilers like it much and easily emit conditionnal set
>instructions. Eg, on x86, this should be something like :
>
>   testl MASK, foo
>   setnz retcode
>
>  
>
>  
>

That was the first thing I'd suggested.

Let's canonize (in the "add to the canon" sense) this.  :)



