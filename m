Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313779AbSDHWEV>; Mon, 8 Apr 2002 18:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313780AbSDHWDm>; Mon, 8 Apr 2002 18:03:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52229 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313779AbSDHWCo>;
	Mon, 8 Apr 2002 18:02:44 -0400
Date: Mon, 8 Apr 2002 23:02:39 +0100
From: "Dr. David Alan Gilbert" <gilbertd@nospam.treblig.org>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
        "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
Message-ID: <20020408220239.GK612@gallifrey>
In-Reply-To: <20020408222742.A28352@infradead.org> <Pine.LNX.4.33.0204081735330.10199-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 22:53:52 up 3 days,  2:31,  5 users,  load average: 2.00, 2.26, 2.52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Hahn (hahn@physics.mcmaster.ca) wrote:
> > See http://people.nl.linux.org/~hch/cpuinfo/ for details.
> 
> egads.  "grep -ci bogo /proc/cpuinfo" then.

Hmm, cpuinfo is a very human readable file, I wouldn't use it to do
things like that.

I suggest /proc/stat whose format appears to be designed for machine
reading and which has a 'cpu0' and 'cpu1' line on this here dual
processor box; and from 2.4.x on it seems to have a cpu0 even on
uniprocessor; so I suggest:

grep "^cpu[0-9][0-9]* " /proc/stat

But I'd actually go and ask the CPU hotswap guys - they must have a way
of getting a handle on this (hey does that mean you might have cpu0,
cpu1, cpu3 .... ?)

Me thinks the format of these /proc files needs documenting - is there
anything already?

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
