Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTDTUbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbTDTUbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 16:31:42 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:55968 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S263693AbTDTUbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 16:31:41 -0400
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
Message-Id: <5.2.0.9.0.20030420132915.01d28c40@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 20 Apr 2003 13:43:40 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: (OT) md5sum proving to be an EXCELLENT memory test
In-Reply-To: <Pine.LNX.4.50.0304201605360.17265-100000@montezuma.mastece
 nde.com>
References: <6uwuhpl2u5.fsf@zork.zork.net>
 <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
 <6uwuhpl2u5.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because the subject of "bad RAM" comes up from time to time on this list, I 
thought I would post an observation I made over the weekend.  I was working 
with some server boxes with "generic" RAM that would mis-behave from time 
to time, and I really didn't understand why that would happen.  The 
misbehavior included some OOPSes from time to time, but they would be 
random and so I didn't report them.

Then I started to grab Red Hat Linux version 9, and because the server 
boxes were the only ones with enough open disk space I started to download 
the ISO images to them.  Imagine my surprise when I went to run md5sum to 
check the download -- they would fail the test.  Perform the test multiple 
times, and the failure pattern would CHANGE.  (Copy the ISOs to another 
system via sftp, along with the MD5SUM, and they checked as 
perfect.)  Perform md5sum on the files on the server and save the results, 
and the signatures would be different from run to run on the same files.

Incompatible RAM.

Proof:  do a kernel computer, get signal 11.  Put the "right" RAM in the 
boxes (in this case, a Viking PE8641U4SN3L-CL3 64-MB stick in an Intel 
CA810E motherboard) and both md5sum and a kernel compile worked just swell.

By the way, md5sum on small files worked perfectly on these server boxes 
with IFA (Taiwan) 128-MB RAM installed, but on large files it would create 
the varied signatures.

So, along with the test of compiling a kernel and seeing if you get signal 
11 messages, you can also load up some large files and run md5sum on them a 
couple of times.  With six ISO images totalling 1.4 GB, it took a 500-MHz 
Pentium II about five minutes to run through the files and show the errors 
-- an order of magnitude faster than trying to do a kernel compile.

FWIW

Stephen Satchell

