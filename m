Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319037AbSHMUmP>; Tue, 13 Aug 2002 16:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319042AbSHMUmP>; Tue, 13 Aug 2002 16:42:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14234 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319037AbSHMUmN>;
	Tue, 13 Aug 2002 16:42:13 -0400
Date: Tue, 13 Aug 2002 13:42:12 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Theurer <habanero@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <2016010000.1029271332@flay>
In-Reply-To: <Pine.LNX.4.44.0208131332440.1265-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131332440.1265-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On a collection of networking workloads the P4 is about 5% better
>> performing with the irq balancer off.
> 
> Hmm. And I could _feel_ how my dual HT P4 was slow before the irq issues 
> were fixed.
> 
> Now, there have been other changes too - like the scheduler (and my
> current P4 has a different SCSI interface), but I dunno. The thing I 
> attributed the improvements in interactive feel was the fact that the work 
> got balanced out more sanely.

Was that before or after you changed HZ to 1000? I *think* that increased
the frequency of IO-APIC reprogramming by a factor of 10, though I might
be misreading the code. If it does depend on HZ, I think that's bad.

People in our benchmarking group (Andrew, cc'ed) have told me that 
reducing the frequency of IO-APIC reprogramming by a factor of 20 or so
improves performance greatly  - don't know what HZ that was at, but the
whole thing seems a little overenthusiastic to me.

M.

