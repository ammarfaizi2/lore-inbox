Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263625AbRFLV7S>; Tue, 12 Jun 2001 17:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263659AbRFLV7J>; Tue, 12 Jun 2001 17:59:09 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:48390 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263625AbRFLV66>;
	Tue, 12 Jun 2001 17:58:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106122158.f5CLwTR253610@saturn.cs.uml.edu>
Subject: Re: threading question
To: davidel@xmailserver.org (Davide Libenzi)
Date: Tue, 12 Jun 2001 17:58:29 -0400 (EDT)
Cc: hch@ns.caldera.de (Christoph Hellwig), linux-kernel@vger.kernel.org,
        ognen@gene.pbi.nrc.ca
In-Reply-To: <XFMail.20010612144449.davidel@xmailserver.org> from "Davide Libenzi" at Jun 12, 2001 02:44:49 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi writes:
> On 12-Jun-2001 Christoph Hellwig wrote:
>> In article <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca> you
>> wrote:

>>> On dual-CPU machines the speedups are as follows: my version
>>> is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
>>> 1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux
>>> 2.4 kernel. Why are the numbers on Linux machines so much lower?
...
> The context switch is very low and the user CPU utilization is 100%,
> I don't think it's system responsibility here ( clearly a CPU bound
> program ).  Even if the runqueue is long, the context switch is low.
> I've just close to me a dual PIII 1GHz workstation that run an MTA
> that uses linux pthreads with context switching ranging between 5000
> and 11000 with a thread creation rate of about 300 thread/sec (
> relaying 600000 msg/hour ).  No problem at all with the system even
> if the load avg is a bit high ( about 8 ).

In that case, this could be a hardware issue. Note that he seems
to be comparing an x86 PC against SGI MIPS, Sun SPARC, and Compaq
Alpha hardware.

His data set is most likely huge. It's DNA data.

The x86 box likely has small caches, a fast core, and a slow bus.
So most of the time the CPU will be stalled waiting for a memory
operation.

Maybe there are performance monitor registers that could be used
to determine if this is the case.

(Not that the app design is sane though.)

