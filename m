Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWINPi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWINPi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWINPi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:38:27 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:3977 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750839AbWINPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fs59qqvQIjVWoSWbnO2bfuk8nT7/bRwPU4Z+C5Q0md5xOu52EdUUon1zGPjYJ49cjHZsP0JmuxDpNGUyVSwbKzRP8QGaww64uosJFZbJ442WIyUnrsOAS9TVzPGDxxEMcdxeolVFlFVA0IG57PH3wQGxXKlfqMYAxUG0cB9Did8=  ;
Message-ID: <45097767.7010405@yahoo.com.au>
Date: Fri, 15 Sep 2006 01:38:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
References: <45085B31.3080504@yahoo.com.au>  <45084833.4040602@yahoo.com.au> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <22461.1158173455@warthog.cambridge.redhat.com> <21102.1158234082@warthog.cambridge.redhat.com> <450974F2.1020104@yahoo.com.au>
In-Reply-To: <450974F2.1020104@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, my mistake :)

Nick Piggin wrote:

> It is actually larger here.
> 
>    text    data     bss     dec     hex filename
>     970       0       0     970     3ca lib/rwsem-spinlock.o
>     576       0       0     576     240 kernel/spinlock.o
                                            ^^ should be:
        35       0       0      35      23 kernel/rwsem.o

>   =1546
> 
>    text    data     bss     dec     hex filename
>    1310       0       0    1310     51e lib/rwsem.o
>     193       0       0     193      c1 kernel/rwsem.o
>   =1503

Well, it is still larger than the atomic_inc_return variant
after my patch.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
