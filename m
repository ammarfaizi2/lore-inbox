Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267166AbUBSKHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbUBSKHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:07:44 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:17804 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S267166AbUBSKHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:07:41 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16436.35563.593635.277584@laputa.namesys.com>
Date: Thu, 19 Feb 2004 13:07:39 +0300
To: linux-kernel@vger.kernel.org
Cc: ltp-list@lists.sourceforge.net, "dan carpenter" <error27@email.com>
Subject: Re: [Announce] Strace Test
In-Reply-To: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
References: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan carpenter writes:
 > Good evening,
 > 
 > I'm happy to announce the initial public release of 
 > Strace Test.  I believe Strace Test is the most 
 > aggressive general purpose kernel tester available.
 > Strace Test generally crashes my system within 
 > 5 minutes (2.6.1-rc2).
 > 
 > Strace Test uses a modified version of strace 4.5.1.  
 > Instead of printing out information about system calls, 
 > the modified version calls the syscalls with improper 
 > values.

It immediately DoSes kernel by calling sys_sysctl() with huge nlen:
printk() consumes all CPU.

Nikita.
