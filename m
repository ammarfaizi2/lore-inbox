Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268820AbUHUCVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268820AbUHUCVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 22:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUHUCVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 22:21:35 -0400
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:30672 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S268820AbUHUCVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 22:21:09 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C14859EA-F318-11D8-9C0E-000A958E2366@mn.rr.com>
Content-Transfer-Encoding: 7bit
Cc: kaos@oss.sgi.com
From: Chris Johns <cbjohns@mn.rr.com>
Subject: Dumping kernel log (dmesg) and backtraces after a panic
Date: Fri, 20 Aug 2004 21:21:05 -0500
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're using Red Hat EL3 Linux (2.4.21 base kernel plus 300 or so Red 
Hat and/or community patches) and I'm dearly missing KDB already, since 
we previously used 2.4.21 from kernel.org and applied the appropriate 
KDB patch(es). Now with EL3, I'm not even sure what the right patch for 
KDB would be.

The problem is how to debug a hang or panic without KDB. Specifically, 
I'd like to dump out real backtraces of all (or selected) processes 
instead of the pseudo-backtraces that the panic or Alt-Sysrq-t 
provides, and I'd like to dump out the kernel log buffer (dmesg) after 
a hang or panic.

When I say "pseudo-backtraces", it seems that the oops/sysrq processing 
picks everything that looks like a text address from the stack of each 
thread (or the thread that caused the panic) and formats it, rather 
than walking the stack back correctly like KDB's 'bt' command does. And 
I don't know of any way of getting the 'dmesg' output after a 
hang/panic other than by using KDB.

To put it simply, is there either an alternative to KDB that works with 
RH EL3 and provides what I need (bt and dmesg, or just dmesg), or is 
there a version of KDB that would work with EL3 already?

Thanks,

Chris Johns

