Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbTBUUrD>; Fri, 21 Feb 2003 15:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTBUUrD>; Fri, 21 Feb 2003 15:47:03 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:60102 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S267693AbTBUUrC>; Fri, 21 Feb 2003 15:47:02 -0500
Message-Id: <4.3.2.7.2.20030222004531.00b56fb0@desh>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 22 Feb 2003 02:27:00 +0530
To: linux-kernel@vger.kernel.org
From: Sudharsan Vijayaraghavan <svijayar@cisco.com>
Subject: Accessibility of variables between kernel modules
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am using 2.4 kernel . In this release i find that all non-static symbols
( functions/variables) defined in one kernel module are exported by default 
to other kernel modules .
If we would use EXPORT_NO_SYMBOLS this exporting of symbols is prevented . 
However we can export one of the symbols in one module using EXPORT_SYMBOL 
and then prevent the export of others by immediately calling EXPORT_NO_SYMBOLS.

We can even use EXPORT_SYMBOL_GPL to export a symbol from a given module , 
these could be accessed by
only those modules using MODULE_LICENSE() and are GPL compatible.

However my requirement is quite different. It is as follows.

I have two kernel modules A and B. Is it possible that the variables in 
kernel module A should only be visible to kernel module B and no other 
kernel modules in the system.
If so please help me out with some explanation.
Really appreciate your help regarding the same.

Thanks in advance,
Sudharsan.

