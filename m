Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTDOVcP (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTDOVcP 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:32:15 -0400
Received: from qwws.net ([213.133.103.108]:55271 "HELO qwwsII.qwws.net")
	by vger.kernel.org with SMTP id S264103AbTDOVcK 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:32:10 -0400
From: Tom Winkler <tom@qwws.net>
Reply-To: tom@qwws.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre7(ac1) - BUG at filemap.c:81
Date: Tue, 15 Apr 2003 23:43:59 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304152344.00096.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With kernel 2.4.21pre7 as well as kernel 2.4.21pre7-ac1 I get a message
about a "kernel BUG at filemap.c:81!" (see below). The message comes
"from time to time" (but the system seems to keep running without
problems). The bug can be reproduced by doing a hdparm -tT. The T part
(disk reads) is not completed but the message below is displayed.

The Kernel is also patched with the latest acpi patch as well as with
the i810 (lite) framebuffer driver.
A full dmesg along with an lspci can be found at
http://www.wnk.at/tmp/dmesg.txt and
http://www.wnk.at/tmp/lspci.txt


kernel message when running "hdparm -tT"; system keeps running:

kernel BUG at filemap.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d03e>]    Not tainted
EFLAGS: 00010206
eax: 0a610000   ebx: 00000000   ecx: c11a5fe0   edx: cfe75c5c
esi: c11a5fe0   edi: cfe75c5c   ebp: cd98a820   esp: cd66feb4
ds: 0018   es: 0018   ss: 0018
Process hdparm (pid: 248, stackpage=cd66f000)
Stack: 00000000 c012da32 cd6767e4 00003643 cfe75c5c c012dad6 c11a5fe0 cd6767e4
       00003643 cfe75c5c c11a5fe0 00000004 0000363f cd98a820 004a8530 c012e119
       0000001f 00000020 00003621 cd98a820 c11a663c cd6767e4 00003621 c012e50c
Call Trace:    [<c012da32>] [<c012dad6>] [<c012e119>] [<c012e50c>] 
[<c012e8d0>]
  [<c012ea18>] [<c012e8d0>] [<c013be03>] [<c010740f>]

Code: 0f 0b 51 00 3d 55 2e c0 ff 05 64 a2 32 c0 5b c3 89 f6 83 ec


If you need any further information about the setup please let me know. If 
there are any patches you'd like me to test just drop me a line.
I'm not subscribed to lkm so please cc me on your replies.

Bye,
-- 
Tom Winkler
e-mail: tom@qwws.net
