Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTDYPzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 11:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbTDYPzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 11:55:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8832 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263340AbTDYPzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 11:55:09 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304251610.h3PGAiri001509@81-2-122-30.bradfords.org.uk>
Subject: Re: Simple x86 Simulator (was: Re: Flame Linus to a crisp!)
To: miller@techsource.com (Timothy Miller)
Date: Fri, 25 Apr 2003 17:10:44 +0100 (BST)
Cc: steve@augart.com (Steven Augart), john@grabjohn.com (John Bradford),
       linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3EA9565B.9020905@techsource.com> from "Timothy Miller" at Apr 25, 2003 11:38:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We could not.  Consider just the 8 32-bit-wide legacy x86 registers, 
> > excluding the MMX and FPU registers:
> > (AX, BX, CX, DX, BP, SI, DI, SP).  32 bits x 8 = 2^256 independent 
> > states to look up in the table, each state having 256 bits of 
> > information.  2^264 total bits of information needed.  Assume 1 GB 
> > dimms (2^30 * 8 bits each = 2^33 bits of info), with a volume of 10 
> > cm^3 per DIMM (including a tiny amount of space for air circulation.).
> > Need 34508731733952818937173779311385127262255544860851932776 cubic 
> > kilometers of space.
> >
> > Considerably larger than the volume of the earth, although admittedly 
> > smaller than the total volume of the universe.
> > --Steven Augart
> 
> If this could be done, someone would have done it already.

It's certainly possible to implement most of the functionality of a
very simple processor this way, but applying the idea to an X86
compatible processor was a joke.

What interests me now is whether we could cache the results of certain
opcode strings in a separate memory area.

Say for example, you have a complicated routine that runs in to
hundreds of opcodes, which is being applied to large amounts of data,
word by word.  If one calculation doesn't depend on another, you could
cache the results, and then merely fetch them from the results cache
when the input data repeats itself.

I.E. the processor dynamically makes it's own look-up tables.

John.
