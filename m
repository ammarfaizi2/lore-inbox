Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319220AbSH2PLM>; Thu, 29 Aug 2002 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSH2PLM>; Thu, 29 Aug 2002 11:11:12 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:6408 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S319220AbSH2PLL>;
	Thu, 29 Aug 2002 11:11:11 -0400
Date: Thu, 29 Aug 2002 16:15:28 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: VM Regress 0.7
Message-ID: <Pine.LNX.4.44.0208291605410.31984-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: VM Regress 0.7

Project page: http://www.csn.ul.ie/~mel/projects/vmregress/
Download:     http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.7.tar.gz

This is the fourth release of VM Regress. It is a regression, benchmarking
and test tool for the Linux VM in it's early stages. This will be the last
release for a while as funding in my University is a bit tight these days.
Mine is due to run out in a few months and I have to re-prioritise
what I'm doing unfortunately. I hope to get back working on this once I
have secured external funding to work full time on VM management in
general and Linux in particular.

This release has at least one major bug fix. It would have been triggered by
an SMP machine running an alloc or page faulting validation test. I haven't
heard any reports and I haven't triggered it myself but I'm pretty sure it
would deadlock. The project will now compile cleanly against late 2.5.32
which is the first 2.5 kernel since 2.5.28 it compiled against.  I haven't
managed to test with a 2.5.x kernel but there is no reason it shouldn't
work. I'd be interested in hearing any success/failure stories with 2.5.x

Perl scripts are now provided to run each test and benchmark, produce a
report, graph vmstat output etc so running tests is a lot easier. It will
load/unload modules as necessary to run the test. This reduces a lot of the
drudge work involved with setting up a test. There is also scripts
available for replotting graphs to a given scale so comparing vm's is a
bit easier. man pages and online help is available for each of them.

The mmap module will now run read or write benchmarks on either anonymous or
file backed maps. It produces graphs showing age of pages, reference counts,
page present/swapped, what pages were referenced over time, vmstat output
and some timing information. It still doesn't do statistical analysis but
that was in the works for 0.9 . the data files are all preserved as .data
files so any stats tool that can import space separated files can be used.
Links to sample test output is on the webpage.

If I get back working on this, 0.8 will have the simulated webserver originally
outlined by Rik Van Riel. Most of what is needed is already there with the
mmap module bench_mmap.pl uses.

Documentation is reasonably up to data and provided with the package. If
people have suggestions or reports, send them on and I'll add them to the
ToDo list. I'll continue to work on this periodically.

Full changelog for 0.7

Version 0.7
-----------
  o Updated bench_mapanon.pl to perform read/write tests
  o Adapted mapanon.o and changed to mmap.o so it can map file descriptors
  o Adapted bench_mapanon.pl to bench_mmap.pl to be a generate mmap benchmark
  o Told benchmark to preserve sampling data
  o Time.pm exports new timing functions
  o mapanon.o changed to mmap.o, handles files or anonymous memory
  o Added graph to show page age vs page presence
  o Added graph to show reference pattern
  o Added replot.pl for easy replotting of time data
  o Fixed access permissions to alloc and fault tests
  o Removed stupid deadlock with alloc and fault modules
  o Various perl lib updates
  o Will now compile against late 2.5.x kernels (untested)
  o Automatically load and unload kernel modules

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

