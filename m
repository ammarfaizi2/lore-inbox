Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268041AbTB1Raz>; Fri, 28 Feb 2003 12:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbTB1Raz>; Fri, 28 Feb 2003 12:30:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268041AbTB1Ray>;
	Fri, 28 Feb 2003 12:30:54 -0500
Date: Fri, 28 Feb 2003 09:36:32 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-Id: <20030228093632.7bf053ed.rddunlap@osdl.org>
In-Reply-To: <8550000.1046419962@[10.10.2.4]>
References: <8550000.1046419962@[10.10.2.4]>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 00:12:42 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

| I was trying to write some simple docs on how to do profiling for people 
| to use for really basic stuff. I got it all wrong, but John's kindly 
| corrected  it ;-) Andrew asked me to do this as a patch for the 
| documentation directory ... feedback would be much appreciated 
| (yes, it's oversimplified - it's meant to be).
| 
| diff -urpN -X /home/fletch/.diff.exclude virgin/Documentation/basic_profiling.txt oprofile_doc/Documentation/basic_profiling.txt
| --- virgin/Documentation/basic_profiling.txt	Wed Dec 31 16:00:00 1969
| +++ oprofile_doc/Documentation/basic_profiling.txt	Fri Feb 28 00:05:59 2003
| @@ -0,0 +1,44 @@
| +These instructions are deliberately very basic. If you want something clever,
| +go read the real docs ;-) Please don't add more stuff, but feel free to 
| +correct my mistakes ;-)    (mbligh@aracnet.com)
| +Thanks to John Levon and Dave Hansen for help writing this.
| +
| +<test> is the thing you're trying to measure.
| +Make sure you have the correct System.map / vmlinux referenced!
| +IMHO it's easier to use "make install" for linux and hack /sbin/installkernel
| +to copy config files, system.map, vmlinux to /boot.
| +
| +Readprofile
| +-----------
| +get readprofile binary fixed for 2.5 / akpm's 2.5 patch from 
| +ftp://ftp.kernel.org/pub/linux/people/mbligh/tools/readprofile/
| +add "profile=2" to the kernel command line.
These:          ^------------v  should be the same value (as you have it).
                             v
| +clear		echo 2 > /proc/profile
man page says to use "readprofile -r".  Doesn't that still work?

| +		<test>
| +dump output	readprofile -m /boot/System.map > catured_profile
                                                > captured_profile


--
~Randy
