Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTKMMsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbTKMMsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:48:20 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:36878 "EHLO
	int-mx1.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264040AbTKMMsT (ORCPT <rfc822;linux-kernel@vger.redhat.com>);
	Thu, 13 Nov 2003 07:48:19 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Linux Kernel <linux-kernel@vger.redhat.com>
Subject: 2.6.0-test9 and /dev/initctl
Date: Thu, 13 Nov 2003 23:48:12 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311132348.12766.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.6.0-test9 running on both Fedora and Debian/unstable there is a 
problem with file handles.

It seems that the kernel somehow gets an open file handle for /dev/initctl (I 
still haven't determined how) and then passes it on to any processes it forks 
(IE modprobe and hotplug).

This shows up when running SE Linux as neither modprobe nor hotplug are 
permitted to access /dev/initctl in any way and the kernel message log 
records the access that was denied.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

