Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbSJ2XNy>; Tue, 29 Oct 2002 18:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSJ2XNy>; Tue, 29 Oct 2002 18:13:54 -0500
Received: from patan.Sun.COM ([192.18.98.43]:38397 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S262484AbSJ2XNx>;
	Tue, 29 Oct 2002 18:13:53 -0500
Message-ID: <3DBF17AF.8080205@sun.com>
Date: Tue, 29 Oct 2002 15:20:15 -0800
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK SUMMARY] fix NGROUPS hard limit (resend)
References: <200210291932.g9TJWiC30564@scl2.sfbay.sun.com> <1035930763.1332.25.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-10-29 at 19:32, Timothy Hockin wrote:
> 
>>Linus,
>>
>>This patchset removes the hard NGROUPS limit.  It has been in use in a similar
>>form (but with a sysctl-set limit) on our systems for some time.
>>
>>I have a separate patch to convert XFS to the generic qsort(), which I will
>>bounce to SGI if/when this gets pulled.
> 
> 
> What is the worst case stack usage of your qsort ?

Unfortunately, I haven't done an analysis of this algorithm, but quick 
empirical tests for random, reversed, and sorted data show stack usage 
to be about 50% less than glibc's qsort() for large data sets.  We were 
using the qsort() as exists in XFS, but when discussing with Cristoph, 
he asked that we use this qsort() implementation instead.  It seems to 
perform markedly better for large sets, too.




-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

