Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268669AbUHLTVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268669AbUHLTVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268673AbUHLTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:21:40 -0400
Received: from host81-7-2-179.adsl.v21.co.uk ([81.7.2.179]:53469 "EHLO
	hilly.house") by vger.kernel.org with ESMTP id S268669AbUHLTVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:21:33 -0400
Message-ID: <411BC339.30504@vu.a.la>
Date: Thu, 12 Aug 2004 20:21:29 +0100
From: Charlie Brej <brejc8@vu.a.la>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Reproducable user mode system hang
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seem to have found a method to hang the kernel from user mode. The system 
hangs and does not print an Oops. It still responds to network pings but nothing 
else.

I have successfully crashed the 2.6 kernels on three different machines (all 
athlon 2.6 kernels):
Linux rain.cs.man.ac.uk 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 athlon 
i386 GNU/Linux
Linux solem.cs.man.ac.uk 2.6.6-1.374 #1 Wed May 19 12:44:14 EDT 2004 i686 athlon 
i386 GNU/Linux
Linux hogshead 2.4.20-8 #1 Thu Mar 13 17:18:24 EST 2003 i686 athlon i386 GNU/Linux

This problem does not occur on any 2.4 kernel machines I have tried.

Reproducing the problem:

Unfortunately the problem occurs in the middle of a program execution and I have 
been unable to track it down.

Download kmd 0.9.19pre1 from (If anyone wants I could distribute my binarys):
http://www.cs.man.ac.uk/~brejc8/kmd/dist/KMD-0.9.19.pre1.tar.gz
In user mode configure, compile and execute from the source directory:
"./kmd -e ./jimulator"
In the memory windows in the address box type in "E1000000" and press return.
This should now crash the system.

Kmd sporns an emulator (jimulator) with which it communicates using stdin/out 
pipes. I suspect it is a problem in the pipe communication. It occurs even when 
run under valgrind. I don't know of many methods of narrowing down the search.

-- 
         Charlie Brej
APT Group, Dept. Computer Science, University of Manchester
Web: http://www.cs.man.ac.uk/~brejc8/ Tel: +44 161 275 6844
Mail: IT302, Manchester University, Manchester, M13 9PL, UK
