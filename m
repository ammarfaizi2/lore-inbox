Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRDQLYU>; Tue, 17 Apr 2001 07:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRDQLYK>; Tue, 17 Apr 2001 07:24:10 -0400
Received: from ivanova.coker.com.au ([203.36.46.209]:36359 "HELO
	ivanova.coker.com.au") by vger.kernel.org with SMTP
	id <S132056AbRDQLXx> convert rfc822-to-8bit; Tue, 17 Apr 2001 07:23:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: linux-kernel@vger.kernel.org
Subject: Mylex DAC vs RAM disk in 2.4.2 devfs
Date: Tue, 17 Apr 2001 13:22:01 +0200
X-Mailer: KMail [version 1.2]
Cc: rgooch@atnf.csiro.au
MIME-Version: 1.0
Message-Id: <01041713220107.28478@lyta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just upgraded a machine with a Mylex DAC hardware RAID controller to 
kernel 2.4.2 with devfs.

It seems that /dev/rd is used by both the RAM disk in the kernel and the 
Mylex controller!

This is wrong of course, there are two problems, one is the situation of what 
happens if you need both Mylex RAID and a RAM disk.  The other is the problem 
that Mylex devices get treated as ram disks by devfsd which cause an upgrade 
to break (the compatibility sym-links are not created correctly).
I believe that the RAM disk should be changed as /dev/rd has been used by 
Mylex controllers for a long time.  I am willing to submit patches to the 
kernel and to devfsd if this suggestion is accepted and someone can suggest a 
good directory name for ram-disks (I don't want to have the same problem 
again).

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page
