Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUDJRa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 13:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUDJRa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 13:30:57 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:48884 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262071AbUDJRax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 13:30:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 10 Apr 2004 13:30:47 -0400 (EDT)
To: linux-kernel@vger.kernel.org, ltt-dev@shafik.org, ltt@shafik.org
Cc: trz@us.ibm.com, karim@opersys.com
Subject: LTT
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16504.12007.769936.508674@k42.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When LTT was considered for 2.5 there was push back because it was felt
that there wasn't a community of people interested in it.  With 2.7 on the
horizon and a little more emphasis on RAS features, this presents a good
opportunity to consider LTT.  It has continued to be cleaned, has been
integrated with relayfs, and can use dprobes so that trace points do not
need to "pollute" the code.  As LTT is considered for 2.7, I thought it
would be useful to show this group the positive interest that it receives
on the LTT mailing list by occasionally forwarding comments about its use
by members of that community.  As always, Karim, Tom, and others are
available to address technical concerns.  Users of ltt should consider
posting to lkml if they would like to demonstrate an interest to seeing
it included in 2.7.

Thanks.

Robert Wisniewski
The K42 MP OS Project
http://www.research.ibm.com/K42/
bob@watson.ibm.com



> To: ltt@shafik.org
> Subject: [ltt] [LTT-0.9.6pre2] -P[pid] option doesn't works
> Date: Wed, 31 Mar 2004 11:17:19 +0200
> 
> Hi everybody,
> 
> First, i have to say that LTT is amazing: I can verify all the theory I 
> read about linux kernel!
> 
> I run a RedHat9.0 upgraded to kernel 2.6.2, on classic PIII550.
> It took me time but I managed to patch this kernel and the toolkit to 
> version 0.9.6pre2 (RelayFS support).
> and also to know how to run the daemon: the doc is great but little bit 
> old ;-(
>  (mount -t relayfs relayfs /mnt/relay)
> Anyway, I managed to make LTT trace very fine, and to display those 
> traces: wonderful!
> 
> So, my problem is that, when I trace the whole processes, it works fine:
> 
> [root@P50705 TraceToolkit-0.9.6pre2]# tracedaemon -ts3 trace.out proc.out
> TraceDaemon: Tracer open
> TraceDaemon: Tracer set to default config
> TraceDaemon: Using the lock-free tracing scheme
> TraceDaemon: Using TSC for timestamping
> TraceDaemon: Configuring 4 trace buffers
> TraceDaemon: Trace buffers are 524288 bytes
> TraceDaemon: Fetching eip for syscall on depth : 0
> TraceDaemon: Daemon will run for : (3, 0)
> TraceDaemon: Tracer is configured for 1 CPUS
> TraceDaemon: Output file(s) ready
> TraceDaemon: relayfs mount point: /mnt/relay
> [root@P50705 TraceToolkit-0.9.6pre2]# TraceDaemon: Relay file(s) ready
> TraceDaemon: Done mapping /proc
> TraceDaemon: Daemon will wait for (0, 320000) to allow 32 processes to 
> finish writing events
> TraceDaemon: End of tracing
> 
> But when I want to trace only one PID, here is the result:
> (console 1)
> [root@P50705 ]# yes >/dev/null
> (console 2)
> [root@P50705 ]# ps aux
> [....]
> root      1874  0.0  0.3  3424  440 ttyp0    R    13:32   0:03 yes
> root      1875  0.0  0.5  2636  684 ttyp1    R    13:33   0:00 ps aux
> [root@P50705 TraceToolkit-0.9.6pre2]# tracedaemon -ts3 -P1874 trace.out 
> proc.out
> TraceDaemon: Tracer open
> TraceDaemon: Tracer set to default config
> TraceDaemon: Using the lock-free tracing scheme
> TraceDaemon: Using TSC for timestamping
> TraceDaemon: Configuring 4 trace buffers
> TraceDaemon: Trace buffers are 524288 bytes
> TraceDaemon: Unable to set the tracer to track the given PID
> 
> If anybody have a suggestion, it will be greatly appreciated.
> Thanks you by advance, and sorry for my english wich is not perfect at 
> all ;)
