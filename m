Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318098AbSFTC0p>; Wed, 19 Jun 2002 22:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSFTC0o>; Wed, 19 Jun 2002 22:26:44 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:50148 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318098AbSFTC0o> convert rfc822-to-8bit; Wed, 19 Jun 2002 22:26:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Skip Gaede <sgaede@attbi.com>
To: linux-kernel@vger.kernel.org
Subject: Memory leak
Date: Wed, 19 Jun 2002 22:24:03 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206192224.03785.sgaede@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I'm looking for a recipe on how to track where my memory is 
disappearing to. I am running kernel 2.4.19-pre10-ben0, 
patched for the nubus-pmac platform. I have 40 MB RAM and a 
100 MB swap file on the local hard disk.

I am using the MkLinux booter and the kernel with an initrd. 
During the first init, I get an IP address and the path to 
the NFS root. I then do a pivot-root, and run the XFree86 
Server -query 192.168.0.1, where I do an autologon, and 
start up KDE 3.0.1 and Mozilla 1.0 running Choffman's 
browser buster. I also am running the snmp daemon, so I can 
monitor memory use from my server with a perl script.

When first booted, the kernel takes about 16 MB of memory, 
and after starting the X server, I have about 2000k 
available physical memory, and no swap file useage. Over 
the next 7 hours, I eat up about 20 MB of swap file, and at 
some point the available physical memory drops down to 
about 150k for about an hour and then the system locks up.
During the same period of time, I can monitor memory use on 
the client on another console, and the amount of memory 
allocated to each process remains fairly stable.

I'd like to understand what's going on. Can someone suggest 
what data I ought to be collecting, or perhaps some 
parameters I can tweak to modify the behavior?

Thanks,
Skip
