Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbUKTG5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUKTG5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUKTG5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:57:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58342 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262746AbUKTG5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:57:16 -0500
Message-ID: <419EEAD2.4020600@us.ibm.com>
Date: Fri, 19 Nov 2004 22:57:22 -0800
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Re: [PATCH] kdump: Fix for boot problems on SMP]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My following original message didn't make it the mailing list hence i am 
resending it.

-------- Original Message --------
Subject: 	Re: [PATCH] kdump: Fix for boot problems on SMP
Date: 	Fri, 19 Nov 2004 22:27:06 -0800
From: 	Vara Prasad <varap@us.ibm.com>
To: 	pbadari@us.ibm.com
CC: 	Andrew Morton <akpm@osdl.org>, Akinobu Mita 
<amgta@yacht.ocn.ne.jp>, hari@in.ibm.com, Linux Kernel Mailing List 
<linux-kernel@vger.kernel.org>, prasadav <prasadav@us.ibm.com>





pbadari@us.ltcfwd.linux.ibm.com wrote on 11/19/2004 03:29:04 PM:

 > Hi Andrew,
 >
 > I haven't tested it yet on any of my machines (due to the hang).
 > I am about to give it a try. But my understanding (please update
 > me if I am wrong) is,
 >
 > 1) DISCONTIG_MEM support is not working yet - so i can't use any
 > of my NUMA boxes.
The initial patch submitted to Andrew didn't include the NUMA
support hence it is not expected to work on NUMA. We are testing
the DISCONTIG_MEM patch, we will submit after finishing the testing.
 >
 > 2) AMD64 is not supported - i can't use my Opteron machine.
 >
 > 3) ppc is not supported - i can't use Power3 and Power4 machines.

First set of patches are only meant to support 32bit x86 platform.
Plan is to support Opteron and other platforms after stabilizing
the initial patches. We are working on porting to AMD64 and PPC
platforms.

 >
 > So, I can only try it on non-NUMA i386 smp boxes. I have few of
 > those to try. I will give an update next week on my testing.
You can try on i386 UP and SMP boxes. Thanks for your help
in testing these patches.
 >
 > Thanks,
 > Badari
 >
 >
 > On Fri, 2004-11-19 at 15:30, Andrew Morton wrote:
 > > Akinobu Mita <amgta@yacht.ocn.ne.jp> wrote:
 > > >
 > > > On Thursday 18 November 2004 23:08, Hariprasad Nellitheertha wrote:
 > > >
 > > > > There was a buggy (and unnecessary) reserve_bootmem call in the 
kdump
 > > > > call which was causing hangs during early on some SMP machines. The
 > > > > attached patch removes that.
 > > >
 > > > Thanks! I also had the same problem.
 > >
 > > So..  How is the crashdump code working now?  I haven't heard from 
anyone
 > > who is using it and I haven't gotten onto testing it myself.
 > >
 > > Do we have any feeling for its success rate on various machines, 
and on its
 > > ease of use?
 > >
 > >
 >

bye,
Vara Prasad
IBM  Linux Technology Center
Phone: 503-578-3303
Tie Line: 775-3303
email: varap@us.ibm.com
---------------------------------------------------------------------------------------------
If we pause to think, we will have a cause to thank. -Anonymous

