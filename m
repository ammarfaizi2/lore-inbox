Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTFBQgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTFBQgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:36:44 -0400
Received: from mout1.freenet.de ([194.97.50.132]:24468 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S264504AbTFBQgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:36:42 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
Date: Mon, 02 Jun 2003 18:55:48 +0200
Organization: privat
Message-ID: <bbfvik$24e$1@ID-44327.news.dfncis.de>
References: <fa.hnjaa1v.19gukhb@ifi.uio.no> <fa.h2i5rk8.1c3cq0m@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1054572948 2190 192.168.1.3 (2 Jun 2003 16:55:48 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.2
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:

> On Sunday 01 June 2003 19:00, Andreas Hartmann wrote:
>>
>> Well, I did the test with 2.4.21rc6 after patching your script (I got
>> syntax errors):
> 
> About your script changes, I like to make it portable, and I use the
> following versions:
> 
> GNU bash, version 2.05b.0(1)-release (i386-redhat-linux-gnu)

2.02.1(1)-release

> 
> dd (coreutils) 4.5.3

dd (fileutils) 4.1

> What shell and coreutils are you using?

They are obviously much older :-).

> Avoiding short counts is easy but avoiding C-style expressions is
> primitive
> 
> -     count=100K
> +     count=100000
> 
> -   while (( i-- )); do
> +   while (( i=`expr $i - 1` )); do
> 
> In your opinion are your changes more portable across a wide range of
> systems?

I didn't think at portability :-). I only made it working for me. Maybe
there are other persons out there who do have some old versions too - so
they can use this patch.

>> When I'm using the script as seen in the patch, I'm getting problems with
>> df (it's mostly very lazy, about 20s delay or more), the load is 4, doing
>> an ls on some other directories is extremly slow. Mouse and keyboard are
>> hanging some times.
>> The write speed shown in xosview was between 1 and 15MB/s. Often the HD
>> LED was on, but no data seemed to be put to the HD.
>>
> 
> It has a hard time to read anything else, the slower the disk, the worse.
> 
> Suppose rmap undoes the fixes introduced in -rc6.
> 
> Have you tried -rc6 plain?

Yes - I only tested this kernel.



Regards,
Andreas Hartmann
