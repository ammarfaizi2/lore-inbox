Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154887-31090>; Tue, 15 Dec 1998 16:26:48 -0500
Received: from MERCURY.CS.UREGINA.CA ([142.3.200.53]:19787 "EHLO MERCURY.CS.UREGINA.CA" ident: "karimi") by vger.rutgers.edu with ESMTP id <155380-31090>; Tue, 15 Dec 1998 15:40:31 -0500
Date: Tue, 15 Dec 1998 15:13:28 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: linux-kernel@vger.rutgers.edu
Subject: Distributed Programming with DIPC
Message-ID: <Pine.SGI.3.91.981215151225.5223A-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

To people interested in distributed programming and clustering under Linux,

 This is to introduce DIPC (Distributed Inter-Process Communication). 
DIPC is a software-only solution for very easy distributed programming under 
the Linux operating system. Here developers design their applications 
as a group of processes, each possibly running on a different Linux computer, 
and then use DIPC to _transparently_ exchange data between them. The main 
objective of the DIPC project is to make distributed programming as much like 
"normal" programming as possible.

 DIPC hides itself behind UNIX System V's IPC mechanisms, consisting of 
Semaphores, Messages, and Shared Memories, and makes them work over a network. 
This means that DIPC offers, among other things, Transparent Distributed 
Shared Memory (DSM) with strict consistency: Processes can read from and 
write to the shared memory with no need for any explicit synchronization!
This makes DIPC very different from systems like PVM or MPI. The source code 
of a DIPC program is nearly identical to a normal UNIX program using System V 
IPC. Actually, a DIPC program can even run in a Linux computer with no DIPC 
support; no need for recompilation. System V IPC is widely available in 
UNIX variants, and is very well documented, meaning that developers may 
already know the programming interface, or they can learn it very easily, 
confident that the usefulness of the newly learned material is not tied to 
the availability of DIPC. This is in sharp contrast to most other distributed 
programming systems.

 Using a mainly "shared-memory" programming interface means that the same 
distributed application can also run on a multi-processor Linux machine
at "full speed"

 DIPC modifies the Linux kerenl in order to offer its excellent degree of 
transparency. There are no needs for any link libraries, and it can be 
used from any programming language that allows access to the OS calls.
The hardware can consist of a single Linux machine, or a cluster of computers 
connected to each other by a TCP/IP network. DIPC has been tested on 
inter-continental WANs and is a heterogeneous system, as it can run on 
Linux/i386 and Linux/m68k, with both versions being able to talk to each
other. (volunteers for porting DIPC to other CPU families are welcome).

 People intersted in distributed systems can easily and safely try DIPC. After 
patching a standard Linux kernel, DIPC becomes a configuration option 
(make config), and can be left out at compile time if desired. When DIPC is 
compiled in, it can be turned off any time with no need for a reboot.

 For more more information about DIPC, visit http://wallybox.cei.net/dipc . 
You can download the package (which includes the sources and the 
documentation) from the web page, or from ftp://wallybox.cei.net/pub/dipc . 
A mailing list devoted to discussions about DIPC is addressed at
linux-dipc@wallybox.cei.net . Feel free to send your comments and questions
here. To view the previous posts to DIPC's mailing list target your browser 
at http://wallybox.cei.net/dipc/ml-archive .

-Kamran Karimi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
