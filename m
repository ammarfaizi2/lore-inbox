Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTKNRDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTKNRDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:03:14 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:48651 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S264585AbTKNRBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:01:36 -0500
Message-ID: <3FB50CA4.9080108@techsource.com>
Date: Fri, 14 Nov 2003 12:11:00 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "things are about right" kernel test?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having recently built a new PC for running Linux, one of the things I 
wanted to do right away was test to make sure that everything was 
performing as it should.  Periodically, someone will post to the list, 
complaining about something or other being slow, and then another person 
responds with a simple kernel parameter change to fix it.  Well...

What I want to know is if there is any tool that's been developed to 
determine if various aspects of system performance are within tolerance. 
  (say, I/O scheduler latency/throughput, process scheduler 
latency/throughput, network, and unrelated things which can have 
performance issues)

My system seems to be just fine, but honestly, I can't really be sure. 
Despite the fact that it's on mirrored raid of two WD1200JB drives, it 
doesn't SEEM (insert comment about flawed human perception) to boot much 
faster than my last Linux box.  This is an example of something which I 
would like to have objective analysis of.

Obviously, one way to check this is to run a myriad of performance 
benchmarks and then compare them to comparable systems, etc.  But this 
is overkill for what I think really only requires a simple "quick and 
dirty sanity check".

If this kind of tool doesn't exist, then I would be interested in taking 
suggestions to get started on this.

Some Q&D tests that I think should be run might include:

- Check disk perf by reading and writing a file larger than RAM.  We 
sanity check this by comparing against results from other systems.

- Check memory perf.  We should be able to test different kinds or 
systems with different kinds of RAM and have the program check to see if 
actual system performance is sane.

- Don't know what to do about network performance without a special setup.


I recall some people mentioning that if they have 1GiB of RAM, something 
(I forget what) performs badly.  They set it to 900-some MiB, and then 
things work better.  A test for that with built-in tips for solving the 
problem might be helpful.

In fact, there are numerous things which I have seen mentioned which 
require tweaks and require simple suggestions to fix.


In addition to being a sanity check, this program could act as sortof a 
FAQ for people with common problems.  They run it, it finds the problem, 
and then tells them what to do about it.  Furthermore, this can help 
kernel developers with identifying problems with new systems (KT600, for 
example).


Right now, I'm going to go off and code up some simple stuff to 
demonstrate that I'm serious about this.  :)


