Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129334AbRA0EfZ>; Fri, 26 Jan 2001 23:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRA0EfQ>; Fri, 26 Jan 2001 23:35:16 -0500
Received: from co3006317-a.thorn1.nsw.optushome.com.au ([203.164.22.27]:24842
	"HELO drongo.taudelta.com.au") by vger.kernel.org with SMTP
	id <S129334AbRA0EfG>; Fri, 26 Jan 2001 23:35:06 -0500
Message-ID: <3A724FD2.3DEB44C@reptechnic.com.au>
Date: Sat, 27 Jan 2001 15:34:26 +1100
From: John Sheahan <john@reptechnic.com.au>
Organization: Tau Delta
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ps hang in 241-pre10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
my box has been running 2.4.1-pre10 for three days.
This morning I noticed odd behavioue - ps and top wouuld freeze 
with no output.

running strace on 'ps'
open("/proc/669/environ", O_RDONLY)     = 7
read(7, "INIT_VERSION=sysvinit-2.78\0previ"..., 2047) = 254
close(7)                                = 0
stat("/proc/683", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/683/stat", O_RDONLY)        = 7
read(7, 
 --- and things just stop in that window--

I cannot read from /proc/683/<anything>
process 683 does not show up in /var/log/messages. How to I find 
what it is?
Any suggestions on how to debug?

Kernel 2.4.1-pre10 on a 2-processor i686
the box has run various 240-test for no unusual issues.
john
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
