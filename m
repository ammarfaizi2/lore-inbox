Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312818AbSCVVKz>; Fri, 22 Mar 2002 16:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSCVVKp>; Fri, 22 Mar 2002 16:10:45 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:49021 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S312818AbSCVVKg>; Fri, 22 Mar 2002 16:10:36 -0500
Date: Fri, 22 Mar 2002 15:10:35 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200203222110.PAA26889@tomcat.admin.navo.hpc.mil>
To: walt@nea-fast.com, linux-kernel@vger.kernel.org
Subject: Re: printing from command line
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt <walt@nea-fast.com>:
>This is a general linux question, not really a kernel question. Does
>anyone know if there is a "simple" good way to print code from linux at
>the command promt.  On a Solaris machine,
>/usr/openwin/bin/mp -o -l filename
>gives me a page with 2 columuns, user_name, date, and pagenumber at the
>top of each column, and the filename at the bottom of each column. I've
>read  lots of howtos and man pages, even wrote a perl script to wrap the
>lines for me, but I haven't figured out how to get the same format from
>Linux as I do from Solaris.

check the "pr" command:

	pr -m file1 file2

Will format the output in two columns, file1 on the left, file2 on the right.

It doesn't include username, but does have the date (top left) and page number
(top right).

An arbitrary title/heading may be specified with the -h option. The
heading is at the top, center of each page.

I've found that a single column was best based on readability (most source
files will indent so far to the right that only a single column will do).

If you want fancier printing try enscript, this utility allows for 1/2/n
columns. (This one does a nice job for line numbers). The output is
postscript - so options for various fonts and sizes are available.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
