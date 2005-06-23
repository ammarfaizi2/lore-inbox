Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVFWArz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVFWArz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFWArz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:47:55 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:17645 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261880AbVFWAru convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:47:50 -0400
Date: Wed, 22 Jun 2005 17:47:44 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?TWljaGFfXw==?= Piotrowski 
	<piotrowskim@trex.wsi.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Script to help users to report a BUG
Message-Id: <20050622174744.75a07a7f.rdunlap@xenotime.net>
In-Reply-To: <42B9CFA1.6030702@trex.wsi.edu.pl>
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
	<20050622120848.717e2fe2.rdunlap@xenotime.net>
	<42B9CFA1.6030702@trex.wsi.edu.pl>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005 22:52:49 +0200 Micha__ Piotrowski wrote:

| Hi,
| 
| randy_dunlap napisa__(a):
| 
| >On Sun, 19 Jun 2005 22:32:16 +0200 Paolo Ciarrocchi wrote:
| >
| >| Hi all,
| >| what do you think about this simple idea of a script that could help
| >| users to fill better BUG reports ?
| >| 
| >| The usage is quite simple, put the attached file in
| >| /usr/src/linux/scripts and then:
| >| 
| >| [root@frodo scripts]# ./report-bug.sh /tmp/BUGREPORT/
| >| cat: /proc/scsi/scsi: No such file or directory
| >| 
| >| [root@frodo scripts]# ls /tmp/BUGREPORT/
| >| cpuinfo.bug  ioports.bug  modules.bug  software.bug
| >| iomem.bug    lspci.bug    scsi.bug     version.bug
| >| 
| >| Now you can simply attach all the .bug files to the bugzilla report or
| >| inline them in a email.
| >| 
| >| The script is rude but it is enough to give you an idea of what I have in mind.
| >| 
| >| Any comment ?
| >
| >It can be useful.  We certainly see bug reports with a good bit
| >of missing information.
| >
| >I would rather see the script write all /proc etc. contents to just
| >one file (with some headings prior to each file).  One file would be
| >easier to email inline or to attach...
| >
| >---
| >  
| >
| We talk about it (me and Paolo) in private correspondence.
| 
| Here is my version:
| http://stud.wsi.edu.pl/~piotrowskim/files/ort/ort-a5.tar.bz2
| 
| Here is my topic on kerneltrap:
| http://kerneltrap.org/node/5325
| 
| If you have any suggestions, coments, please send me email or post on 
| kerneltrap.

OK, I looked and I have a few suggestions or comments.

1.  ort.sh needs to be run as root so that lspci -vvv and lsusb -v
work as expected.  Maybe include that requirement in 'help'?
Aha, that's what root@ng02 is supposed to mean, right?
I think it should be more explicit than that.

2.  Item 2 (full description) should allow for more than one line
of input.

3.  Item 3 (keywords) probably should allow for more than one line
of input.

4.  Item 4 (kernel version) and all of 7 (Environment) assume that
the oops happened on the system where the oops report is being
produced.  That's probably correct lots of the time, but not always.
But I don't know what to do about it.

5.  Item 7 (small sample program to duplicate problem):  at least put
an empty reminder at this spot, this is a Very Important Program.

6.  Use $EDITOR instead of vim if it is defined (set).

7.  Consider ending with on-screen message to email 'ort_oops.txt'
to linux-kernel@vger.kernel.org or some other appropriate Linux
mailing list.


I did use ort.sh and it produced a pretty good output file.

Thanks,
---
~Randy
