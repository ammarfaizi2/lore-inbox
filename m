Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265895AbUBCHSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 02:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUBCHSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 02:18:37 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:49597 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265895AbUBCHSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 02:18:35 -0500
Message-ID: <401F4A02.7090201@cyberone.com.au>
Date: Tue, 03 Feb 2004 18:13:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, philip@codematters.co.uk
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87smhsy7n4.wl@canopus.ns.zel.ru>
In-Reply-To: <87smhsy7n4.wl@canopus.ns.zel.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Samium Gromoff wrote:

>>>The machine is a dual P3 450MHz, 512MB, aic7xxx, 2 disk RAID-0 and                   
>>> ReiserFS.  It's a few years old and has always run Linux, most                      
>>> recently 2.4.24.  I decided to try 2.6.1 and the performance is                     
>>> disappointing.                                                                      
>>>
>>                                                                                       
>>2.6 has a few performance problems under heavy pageout at present.  Nick               
>>Piggin has some patches which largely fix it up.                                       
>>
>
>I`m sorry, but this is misguiding. 2.6 does not have a few performance
>problems under heavy pageout.
>
>It`s more like _systematical_ _performance_ _degradation_ increasing with
>the pageout rate. The more the box pages out the more 2.6 lags behind 2.4.
>
>

Well it is a few problems that cause significant performance
regressions. But nevermind semantics...


>What i`m trying to say is that even light paging is affected. And light
>paging is warranted when you run, say, KDE on 128M ram.
>
>Go measure the X desktop startup time on a 48M/64M boxen--even light paging
>causes 2.6 to be just sloower. Also the vm thrashing point is much much earlier.
>
>

Have a look here: http://www.kerneltrap.org/~npiggin/vm/3/
and here: http://www.kerneltrap.org/~npiggin/vm/4/
patches here: http://www.kerneltrap.org/~npiggin/vm/

and I have a couple of things which improve results even more.
True, its only kbuild, but after I do a bit more tuning I'll
focus on other things - I'm hoping most of the improvements
carry over to other cases though.

Tentatively, it looks like 2.6 under very heavy swapping can
actually be significantly improved over 2.4.

>Ask Roger Luethi for details.
>
>

Andrew is quite well versed in the details :)

