Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281566AbRKPWMW>; Fri, 16 Nov 2001 17:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281489AbRKPWMQ>; Fri, 16 Nov 2001 17:12:16 -0500
Received: from ns.suse.de ([213.95.15.193]:34308 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281566AbRKPWL7>;
	Fri, 16 Nov 2001 17:11:59 -0500
Date: Fri, 16 Nov 2001 23:11:56 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <3BF58C31.4050402@stesmi.com>
Message-ID: <Pine.LNX.4.30.0111162302160.22827-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Stefan Smietanowski wrote:

> Would you mind writing what each of these actually is?
> Athlon 661 doesn't tell me much, neither does Duron 671.
> That's just an example, which is which?

The numbers translate to the family/model/stepping fields
of /proc/cpuinfo.

The only older models certified as safe for SMP are.

 Athlon model 6, stepping 0 CPUID = 660
 Athlon model 6, stepping 1 CPUID = 661
 Duron  model 7, stepping 0 CPUID = 670

The newer models..
 model 6 stepping 2 and above 662
 model 7 stepping 1 and above 671

have a cpuid flag that must be compared to find out if they
are capable or not. Note that these id's tally with XP's and MP's.
The capability bit is the only way to distinguish between these models.

Hope this makes it clearer.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

