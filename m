Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131983AbRDJTqu>; Tue, 10 Apr 2001 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131985AbRDJTqk>; Tue, 10 Apr 2001 15:46:40 -0400
Received: from [216.33.104.134] ([216.33.104.134]:40714 "HELO mail.lig.net")
	by vger.kernel.org with SMTP id <S131983AbRDJTqa>;
	Tue, 10 Apr 2001 15:46:30 -0400
Message-ID: <3AD354BB.20F1CE33@lig.net>
Date: Tue, 10 Apr 2001 14:45:15 -0400
From: "Stephen D. Williams" <sdw@lig.net>
Organization: CCI / Insta, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1dp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410140202.A15114@gruyere.muc.suse.de> <E14mx0K-00049P-00@the-village.bc.nu> <20010410143216.A15880@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When this is rewritten, I would strongly suggest that we find a way to
make 'gettimeofday' nearly free.  Certain applications need to use this
frequently while still being portable.  One solution when you do have
clock ticks is a read-only mapped Int.  Another cheap solution is
library assembly that adds a cycle clock delta since last system call to
a 'gettimeofday' value set on every system call return.

sdw

Andi Kleen wrote:
> 
> On Tue, Apr 10, 2001 at 01:12:14PM +0100, Alan Cox wrote:
> > Measure the number of clocks executing a timer interrupt. rdtsc is fast. Now
> > consider the fact that out of this you get KHz or better scheduling
> > resolution required for games and midi. I'd say it looks good. I agree
> 
> And measure the number of cycles a gigahertz CPU can do between a 1ms timer.
> And then check how often the typical application executes something like
> gettimeofday.
> 
...

sdw
-- 
sdw@lig.net  http://sdw.st
Stephen D. Williams
43392 Wayside Cir,Ashburn,VA 20147-4622 703-724-0118W 703-995-0407Fax 
Dec2000
