Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270463AbRHHLvT>; Wed, 8 Aug 2001 07:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270462AbRHHLvJ>; Wed, 8 Aug 2001 07:51:09 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:25863 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S270464AbRHHLuy>;
	Wed, 8 Aug 2001 07:50:54 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: cate@dplanet.ch
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1 is available. 
In-Reply-To: Your message of "Wed, 08 Aug 2001 13:33:38 +0200."
             <3B712392.A7CFEEC9@math.ethz.ch> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Aug 2001 21:50:59 +1000
Message-ID: <1556.997271459@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Aug 2001 13:33:38 +0200, 
Giacomo Catenazzi <cate@math.ethz.ch> wrote:
>Keith Owens wrote:
>> 
>>   Supports a common source and object directory.  The default mode is
>>   the same as kbuild 2.4, to use the same tree for both source and
>>   object.  Even in this mode, kbuild 2.5 treats almost all the source
>>   files as read only, no more time stamp fiddling with .h files.  The
>>   exceptions are files that are generated at run time and are
>>   incorrectly being shipped as part of the kernel tar ball.  I will be
>>   sending patches to remove these files from the 2.4 tar ball.
>>   Obviously you can only compile one kernel at a time in this mode.
> 
>Warning:
>If generating some support files requires some non common tools,
>it is the right thing to ship the two files (source and generated).

Absolutely agree.  But we have files in the tar ball that are generated
using standard tools.

net/802/pseudo/pseudocode.h is shipped, but it is generated using sed.
net/802/pseudo/actionnm.h is shipped, it is generated using sed,
nothing even uses the file.
net/802/transit/pdutr.h and timertr.h are shipped but they are
generated using awk.
net/802/cl2llc.c is shipped but it is generated using sed.

I will remove all of those from the tar ball.

OTOH, files like defkeymap.c (needs loadkeys) or the 53c8xx, 53c7xx and
sim710 firmware (need Perl) must have shipped versions in the tar ball,
I will not be removing them.

