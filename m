Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292379AbSBUNcE>; Thu, 21 Feb 2002 08:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292372AbSBUNb5>; Thu, 21 Feb 2002 08:31:57 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:23221 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S292386AbSBUNbl>;
	Thu, 21 Feb 2002 08:31:41 -0500
Message-ID: <3C74F5F8.3000201@debian.org>
Date: Thu, 21 Feb 2002 14:28:24 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <fa.gq2s5iv.1s4in@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2002 13:31:38.0969 (UTC) FILETIME=[174EB490:01C1BADC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roman Zippel wrote:

> Hi,
> 
> config: ULTRIX_PARTITION
>   define_bool
>     default: y
>     dep: ((!PARTITION_ADVANCED?) && DECSTATION=y)
>   bool
>     prompt:   Ultrix partition table support
>     dep: PARTITION_ADVANCED?
>   help:
>   Say Y here if you would like to be able to read the hard disk
>   partition table format used by DEC (now Compaq) Ultrix machines.
>   Otherwise, say N.
> 


 From old discussion in kbuild list:
1) default: Eric proposed to include defaults in configuration,
    but it seems that is a bad things, and defaults should be arch
    specific. (I don't remember the discussion, but you can
    parse the kbuild list, torque.net time)
2) One of the problem in actual configure are the dependencies.
    FOO depend on BAR and BEER.
    Wat are the possible value of FOO if BAR=m, BEER=y.
    In kernel we have some drivers thet need foo to be n or y,
    in other cases: n or m.
    The logical operators hide the true dependency table.
    (don't expect developers read the docs: the logical operators
    seems like C operators, so they use like C, but they forget
    the third case (=m) ).

Do you use the python identation mode?

	giacomo

