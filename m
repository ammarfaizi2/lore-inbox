Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbTGXV0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271697AbTGXV0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 17:26:04 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:4807 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S269712AbTGXV0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 17:26:02 -0400
Message-ID: <3F205275.3080403@wmich.edu>
Date: Thu, 24 Jul 2003 17:41:09 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Michal Semler <cijoml@volny.cz>, linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling
References: <200307240916.17530.cijoml@volny.cz> <20030724205837.GA1176@mars.ravnborg.org>
In-Reply-To: <20030724205837.GA1176@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Jul 24, 2003 at 09:16:17AM +0200, Michal Semler wrote:
> 
>>Hello,
>>
>>I use gcc-3.3 and I would like compile my kernel with flags:
>>
>>-O4 -march=pentium3 -mcpu=pentium3

-mcpu is taken care of by -march in gcc3
-O4 does nothing, -O3 is the highest gcc3 goes, and -O3 does cause 
problems with certain code.

I'd suggest also -ftracer as it is supposed to help your standard -O2 
level optimizations do their jobs. How well, probably not very noticable 
in real life, but then neither is -march=pentium3 over i686.


>>Is there any way to do this?
> 
> Only way to specify -O4 is to manually edit top-level Makefile.
> Change the assignment to CFLAGS (not hOSTCFLAGS as someone suggested).
> 
> The -m options are set in arch/i386/Makefile.
> The best way to set them is to select the correct processor type.
> 
> 	Sam
> 
basically, makefiles are supposed to add the value of CFLAGS to their 
flag variable.  CXXFLAGS for c++ arguments. But i understand why the 
kernel doesn't do this since it needs strict management over the build.

