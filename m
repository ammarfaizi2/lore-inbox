Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281108AbRKEMdk>; Mon, 5 Nov 2001 07:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281107AbRKEMda>; Mon, 5 Nov 2001 07:33:30 -0500
Received: from mustard.heime.net ([194.234.65.222]:7825 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281105AbRKEMdV>; Mon, 5 Nov 2001 07:33:21 -0500
Date: Mon, 5 Nov 2001 13:33:18 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>, Tux mailing list <tux-list@redhat.com>
Subject: Lots of questions about tux and kernel setup
Message-ID: <Pine.LNX.4.30.0111051238320.18502-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've started a new project where the final goal is to overload
vger.kernel.org with silly questions...

Well... Seriously, I'm working on a project, setting up a web server,
serving large, multi-gigabyte media files (aka streaming). Below, I've
set up a list of questions of things I want to know to tune the system as
good as possible. Thank you all for all help :-)

First of all - the plan now, is to use Tux as the web server, as I've got
the impression - both by testing it, and of what's been said on the list,
that it's one of the fastest solutions I can find - at least on Linux. I
plan to serve some <= 250 concurrent connections, each given a maximum
bandwidht (in tux) of 7 Mbps. The average bandwidth use will be somewhere
between 4 and 5 Mbps, but it may peak at 7. The server I'll set up will
only run Tux - no Apache. Tux will be setup not to log, and virutally all
system daemons will be stopped. Some management agents (from Compaq or
whoever we'll go for) may run, but that's it. I also plan to set it up
without any swap partition.

Q: What would the memory requirements for such a system be? I've read Tux
uses sendfile(), but I don't know how Tux or sendfile() caches. Does
sendfile read the file into the cache buffer before sending it? I mean - I
can't keep the files in memory, so how much would do?

Q: If using the bandwidth control in Tux, how much CPU overhead may I
expect per stream (sizes as mentioned above)?

Q: Do anyone know what SCSI and NIC (1 or 10Gb-Ethernet) that have low or
high CPU overhead? I have the impression that there are quite some
variations between different drivers. Is this true?

Q: Tux has some way of linking IRQs directly to a specific CPU/thread
(don't really remember what this was...). What should/could be used of
these, or other tuning factors to speed up the server?

Q: Are there ways to strip down the kernel, as to get rid of everything I
don't want or don't need? Could I gain speed on this, or is it just a
waste?

Q: What file system would be best suitable for this? Ext[23]? ReiserFS?
Xfs? FAT? :-)

Q: If using iptables to block any unwanted traffic - that is - anything
that's not TCP/80, how much CPU overhead could this generate? Could use of
tcpwrappers or similar systems work better? (I need ssh, snmp and a some
management agents available on the net, but I don't want the end users to
be able to access them).

Well... That's all for now...

Thanks for any help

Regards

roy

---
Computers are like air conditioners.
They stop working when you open Windows.




