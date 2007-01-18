Return-Path: <linux-kernel-owner+w=401wt.eu-S932597AbXARWGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbXARWGk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbXARWGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:06:40 -0500
Received: from s34.avahost.net ([207.44.172.37]:60621 "EHLO s34.avahost.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932597AbXARWGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:06:39 -0500
X-Greylist: delayed 1780 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 17:06:39 EST
Message-ID: <45AFE875.5040204@katalix.com>
Date: Thu, 18 Jan 2007 21:36:53 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Sue Alfano <smalfano@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: uClibc - waitid()
References: <fb6b09f20701180318i5f3b2785sd7f3f0931808b849@mail.gmail.com>
In-Reply-To: <fb6b09f20701180318i5f3b2785sd7f3f0931808b849@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s34.avahost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - katalix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're asking the wrong list. Try the uClibc list at uclibc.org.

glibc and uClibc provide C APIs to kernel system calls. uClibc doesn't 
implement all features that glibc supports - there are several kernel 
APIs that uClibc doesn't expose. Ask the uClibc folk for advice.

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development

Sue Alfano wrote:

> Can anyone help with this?
> 
> We have an application that runs fine on our linux workstations, but
> will not compile to run on a new target.  This application is using
> the WNOWAIT option for the waitid() function.  When the source file is
> compiled for the target using powerpc-uclibc-gcc, it fails because
> WNOWAIT is not defined.  The best that I can tell, waitid() doesn't
> appear to be supported in uClibc (version 0.9.27).  I checked the
> latest version on the uClibc site, but it doesn't appear to have been
> considered for inclusion.  I looked in glibc (versions 2.4, 2.3.5, and
> 2.0.6), but could only find emulated/stub/pseudo implementations for
> waitid().  The Linux man page for waitid() states that it's supported
> since the 2.6.9 kernel release.  At this point I'm not sure where the
> waitid() source code and WNOWAIT definition is suppose to be (kernel,
> uClibc, glibc, gcc) or what version of wait.h is actually being used
> (there appears to be many versions floating around on the machine).
> Since I'm way off in the weeds on this I was hoping somebody with more
> Linux experience than me (that would be just about anyone) might be
> able to shed some light on this problem or point me in a more
> constructive direction.
> 
> Do you have any information as to the status of the waitid() support?
> It must have been available at one time since it's running on my linux
> workstation (Linux version 2.6.15-1.2054_FC5smp
> (bhcompile@hs20-bc1-3.build.redhat.com) (gcc version 4.1.0 20060304
> (Red Hat 4.1.0-3)) #1 SMP Tue Mar 14 16:05:46 EST2006).
> 
> Was there a reason why it wasn't added to uClibc (other than the size 
> issue)?
> 
> Is there a recommended way to deal with applications that are using
> waitid() with the WNOWAIT option?
> 
> Thanks for any assistance,
> Sue
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


