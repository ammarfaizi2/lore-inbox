Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130460AbRAWN2c>; Tue, 23 Jan 2001 08:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130983AbRAWN2X>; Tue, 23 Jan 2001 08:28:23 -0500
Received: from [12.8.178.5] ([12.8.178.5]:56441 "EHLO
	huthqhub1.sunglasshut.com") by vger.kernel.org with ESMTP
	id <S130460AbRAWN2O>; Tue, 23 Jan 2001 08:28:14 -0500
Subject: Re: Turning off ARP in linux-2.4.0
To: elton@iqs.net
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2c (Intl) 2 February 2000
Message-ID: <OF772D0622.4649EE9A-ON852569DD.0048CCA9@sunglasshut.com>
From: NDias@sunglasshut.com
Date: Tue, 23 Jan 2001 08:19:46 -0500
X-MIMETrack: Serialize by Router on Huthqhub1/Hub/Servers/SunglassHut(Release 5.0.5 |September
 22, 2000) at 01/23/2001 08:35:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm very new to this list, and usually lurk for quite awhile before
posting, however I think I can assist here. The 2.4.0 kernel I'm looking at
does give you the option of implementing sysctl support. Please see the
Configure.help in the Documentation section:

Sysctl support
CONFIG_SYSCTL
The sysctl interface provides a means of dynamically changing
certain kernel parameters and variables on the fly without requiring
a recompile of the kernel or reboot of the system. The primary
interface consists of a system call, but if you say Y to "/proc
file system support", a tree of modifiable sysctl entries will be
generated beneath the /proc/sys directory. They are explained in the
files in Documentation/sysctl/. Note that enabling this option will
enlarge the kernel by at least 8 KB.

Hope this helps.

Neal Dias

UNIX Systems Administrator
Sunglass Hut International, MIS Dept.
office: (305) 648-6479
mobile: (786) 368-5742
wk. email: NDias@sunglasshut.com
pvt. email: emperor.1@netzero.net


*******************************************************************************

Whoever fights monsters should see to it that in the process he does not
become a monster. And when you look into an abyss, the abyss also looks
into you. -Nietzsche

Any opinions expressed above or below are entirely my own and may not
reflect those of my employers.

The information contained in this e-mail message is confidential, intended
only for the receipt and use of the individual(s) or entity(s) named above.
If the reader of this email message is not the intended recipient, or the
employee or agent responsible for its delivery to the intended and or
addressed recipient, you are hereby notified that any review,
dissemination, distribution or copying of this communication is strictly
prohibited except at the express consent of its author.






                                                                                                                              
                    Pete Elton                                                                                                
                    <elton@iqs.net>                 To:     linux-kernel@vger.kernel.org                                      
                    Sent by:                        cc:                                                                       
                    linux-kernel-owner@vger.        Subject:     Turning off ARP in linux-2.4.0                               
                    kernel.org                                                                                                
                                                                                                                              
                                                                                                                              
                    01/22/01 03:59 PM                                                                                         
                                                                                                                              
                                                                                                                              




I have searched the previous posts and have not found a solution to
the problem that I am facing.

The short problem is that I need a way to turn off arping for the lo
interface in the 2.4.0 kernel.

In the 2.2 kernel, I could do the following:
echo 1 > /proc/sys/net/ipv4/conf/all/hidden
echo 1 > /proc/sys/net/ipv4/conf/lo/hidden

The 2.4 kernel does not have these sysctl files any more.  Why was
this functionality taken out?  or was it simply moved to another place
in the proc filesystem?  How can I accomplish the same thing I was
doing in the 2.2 kernel in the 2.4 kernel?

Now for the long version of the problem.  I am using the TurboLinux
ClusterServer 6.0 product.  This product uses what they refer to as
an advanced traffic manager that has the ip address of the web site
aliased to eth0.  Thus this machine arps for the ip address and when it
gets the http requests, it passes those requests to the nodes which have
the same ip addressed aliased to their lo interface with arping turned off.

TurboLinux is not helping me with the 2.4 kernel.  I imagine it is because
they know nothing about it and were not planning ahead by following the
development of the 2.3 kernel, so I thought I would ask the guys who really
know what is going on.

I know that you are all very busy, but any help that you can provide
is greatly appreciated.

Pete Elton

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
