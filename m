Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTLVKy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTLVKy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:54:29 -0500
Received: from mail.szintezis.hu ([195.56.253.241]:46489 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S264379AbTLVKy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:54:28 -0500
Subject: [test] exec-shield  vs. paxtest 0.9.5 horrible results
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Dec 2003 11:54:25 +0100
Message-Id: <1072090466.1471.4.camel@gmicsko03>
Mime-Version: 1.0
X-OriginalArrivalTime: 22 Dec 2003 10:54:26.0696 (UTC) FILETIME=[F796D080:01C3C879]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gmicsko03:/home/trey/devel/exploit/paxtest-0.9.5# uname -a
Linux gmicsko03 2.6.0 #1 Thu Dec 18 12:32:44 CET 2003 i686 GNU/Linux

gmicsko03:/home/trey/devel/exploit/paxtest-0.9.5# echo 2 >
/proc/sys/kernel/exec-shield

gmicsko03:/home/trey/devel/exploit/paxtest-0.9.5# cat
/proc/sys/kernel/exec-shield
2

gmicsko03:/home/trey/devel/exploit/paxtest-0.9.5# ./paxtest
PaXtest - Copyright(c) 2003 by Peter Busser <peter@adamantix.org>
Released under the GNU Public Licence version 2 or later

It may take a while for the tests to complete
Test results:
PaXtest - Copyright(c) 2003 by Peter Busser <peter@adamantix.org>
Released under the GNU Public Licence version 2 or later

Executable anonymous mapping             : Vulnerable
Executable bss                           : Vulnerable
Executable data                          : Vulnerable
Executable heap                          : Vulnerable
Executable stack                         : Vulnerable
Executable anonymous mapping (mprotect)  : Vulnerable
Executable bss (mprotect)                : Vulnerable
Executable data (mprotect)               : Vulnerable
Executable heap (mprotect)               : Vulnerable
Executable shared library bss (mprotect) : Vulnerable
Executable shared library data (mprotect): Vulnerable
Executable stack (mprotect)              : Vulnerable
Anonymous mapping randomisation test     : 16 bits (guessed)
Heap randomisation test (ET_EXEC)        : 14 bits (guessed)
Heap randomisation test (ET_DYN)         : 13 bits (guessed)
Main executable randomisation (ET_EXEC)  : No randomisation
Main executable randomisation (ET_DYN)   : 12 bits (guessed)
Shared library randomisation test        : 12 bits (guessed)
Stack randomisation test (SEGMEXEC)      : 17 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 17 bits (guessed)
Return to function (strcpy)              : Vulnerable
Return to function (strcpy, RANDEXEC)    : Return to function
(memcpy)              : Vulnerable
Return to function (memcpy, RANDEXEC)    : Vulnerable
Executable shared library bss            : Vulnerable
Executable shared library data           : Vulnerable
Writable text segments                   : Vulnerable
gmicsko03:/home/trey/devel/exploit/paxtest-0.9.5#


Any idea?



