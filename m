Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQLGF3m>; Thu, 7 Dec 2000 00:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbQLGF3c>; Thu, 7 Dec 2000 00:29:32 -0500
Received: from grunt.okdirect.com ([209.54.94.12]:7 "HELO mail.pyxos.com")
	by vger.kernel.org with SMTP id <S129688AbQLGF3Z>;
	Thu, 7 Dec 2000 00:29:25 -0500
Message-Id: <5.0.2.1.2.20001206223822.03997008@209.54.94.12>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 06 Dec 2000 22:56:32 -0600
To: linux-kernel@vger.kernel.org
From: Daniel Walton <zwwe@opti.cgi.net>
Subject: Out of socket memory? (2.4.0-test11)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've been having a problem with a high volume Linux web server.  This 
particular web server used to be a FreeBSD machine and I've been trying to 
successfully make the switch for some time now.  I've been trying the 2.4 
development kernels as they come out and I've been tweaking the /proc 
filesystem variables but so far nothing seems to have fixed the 
problem.  The problem is that I get "Out of socket memory" errors and the 
networking locks up.  Sometimes the server will go for weeks without 
running into the problem and other times it'll last 30 minutes.  The 
hardware in question is an 1Ghz Athalon system with 256Mb of ram and an IDE 
hard disk.  I've tried every 2.4 test kernel to date.  The web server is a 
specialized web server running about 10 million hits a day.  Of the 256Mb 
of ram the web server uses 40Mb and there are no other significant memory 
consuming processes on the system.  Currently I am using the following 
/proc modifications in the rc.local file.

echo "7168 11776 16384" > /proc/sys/net/ipv4/tcp_mem
echo 32768 > /proc/sys/net/ipv4/tcp_max_orphans

What am I doing wrong?  Is this a kernel problem or a configuration 
problem?  Is there any way I can get runtime information from the kernel on 
things like amount of socket memory used and amount available?  Am I using 
the right variables to increase available socket memory and just not giving 
it enough yet?

I appreciate any help provided.

Thank you,
Daniel Walton


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
