Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313887AbSDIM0Z>; Tue, 9 Apr 2002 08:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313888AbSDIM0Y>; Tue, 9 Apr 2002 08:26:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313887AbSDIM0Y>;
	Tue, 9 Apr 2002 08:26:24 -0400
Date: Tue, 9 Apr 2002 13:26:22 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "T. A." <tkhoadfdsaf@hotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: C++ and the kernel
Message-ID: <20020409122622.GN612@gallifrey>
In-Reply-To: <3CB2BA4C.80200@evision-ventures.com> <Pine.LNX.3.95.1020409075919.4157A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 13:16:22 up 3 days, 16:53,  4 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Richard B. Johnson (root@chaos.analogic.com) wrote:
> 
> I would like to rewrite the kernel in FORTRAN because this was
> one of the first languages I learned.
> 
> Seriously, the kernel MUST be written in a procedural language.
> It is the mechanism by which something is accomplished that defines
> an operating system kernel.
> 
> C++ is an object-oriented language, in fact the opposite of a
> procedural language. It is not suitable.

Bollox!

There are many places in the kernel that are actually very OO - look at
filesystems for example. The super_operations sturcture is in effect a
virtual function table.

Sure making every file an object is probably OTT; but large scale things
like a filesystem, a network device or the like probably actually fit
very well.

Sure, there are a lot of features of C++ to stay clear of - exception
handling probably being one of them, and I wouldn't let the C++ stuff
anywhere near the memory management code.

Point being that it is a case of using the write tool for the job.  C++
douesn't add any extra overhead just by calling it C++ and not using any
of the features; careful use of the features where appropriate does no
harm and might actually make the code cleaner, and possibly more
efficient.

I will agree going head in and just throwing C++ at it is a bad thing.

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
