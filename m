Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVARSNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVARSNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVARSNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:13:43 -0500
Received: from smtpproxy1.mitre.org ([192.160.51.76]:63934 "EHLO
	smtp-bedford.mitre.org") by vger.kernel.org with ESMTP
	id S261365AbVARSNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:13:33 -0500
Message-ID: <41ED51CA.6010206@mitre.org>
Date: Tue, 18 Jan 2005 13:13:30 -0500
From: Jeff Blaine <jblaine@mitre.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: jblaine@mitre.org
Subject: PROBLEM: oom-killer bringing machine down in 2.6.10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this to the NFS list and was told to post
here.

I have a box with 4GB.  It's running Red Hat Fedora Core
3 with 2.6.10 as distributed by them.  No custom kernel
compiling, and no desire :)

The problem reported below DID NOT happen with 2.4.21.
It did happen also with 2.6.9, and I cannot comment on
other kernels.  So, it happens with 2.6.9 and 2.6.10,
but not 2.4.21, and anything else has not been tried.

I am trying to run Iozone with -g and an argument to it
that is larger than the physical memory in the NFSv3
client machine.

For instance, on this 4GB box, I am trying '-g 4224m'.
More specifically, the entire command line is:

      ./iozone -a -g 4224m -f /sol9box/testfile

As soon as it finally gets to trying a file size of
4194304, oom-killer steps in and starts blasting
processes off my machine.  NFS stops functioning,
RPC calls to the box fail, SSH connections are no
longer accepted, and I generally have to hard
powercycle the box.

Reference: http://www.iozone.org/

