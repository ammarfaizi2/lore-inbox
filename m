Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRCCWCs>; Sat, 3 Mar 2001 17:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129809AbRCCWC2>; Sat, 3 Mar 2001 17:02:28 -0500
Received: from web11808.mail.yahoo.com ([216.136.172.162]:33801 "HELO
	web11808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129807AbRCCWC0>; Sat, 3 Mar 2001 17:02:26 -0500
Message-ID: <20010303220225.32501.qmail@web11808.mail.yahoo.com>
Date: Sat, 3 Mar 2001 14:02:25 -0800 (PST)
From: "Frédéric L. W. Meunier" <fredlwm1@yahoo.com>
Subject: 2.4.2: What happened ? (No such file or directory)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I was using 2.4.2 without any problems until a
flood of warnings
from multilog (daemontools) appeared at my console.
What I first thought
to be a log problem seems to be serious. For some
reason applications
and daemons (not all) can't find files.

Mutt doesn't recognize ~/Mail/postponed if I try to
postpone a message:
/home/pervalidus/Mail/postponed: No such file or
directory (errno = 2)

CVS reports cvs [checkout aborted]: cannot rename file
.new.foo to foo:
No such file or directory

Trying to build an application (for example devfsd) I
get:

cc -O2 -I. -Wall    -c -o devfsd.o devfsd.c
In file included from /usr/include/signal.h:307,
                 from /usr/include/sys/wait.h:30,
                 from devfsd.c:188:
/usr/include/bits/sigcontext.h:28: asm/sigcontext.h:
No such file or directory
make: *** [devfsd.o] Error 1

All files and directories are there. I can add, move,
remove, and
edit/save everything. But if I try to move a directory
with mc I get:
Cannot move directory "/foo" to "/bar" No such file or
directory (2)
with mc. It works with mv(1). Also I can't umount the
partitions. I'm
using ext2. Any hints ? My .config is at
http://members.nbci.com/pervalidus/.config-2.4.2.txt

Sorry, I couldn't use Mutt and Exim to send this
message:

==> /var/exim/log/exim_mainlog <==
2001-03-03 16:00:17 14ZHGL-0000Yj-00 Message
abandoned: Spool write error (No such file or
directory) while receiving message from pervalidus
2001-03-03 16:00:17 14ZHGL-0000Yk-00 Message
abandoned: Spool write error (No such file or
directory) while receiving message from exim
2001-03-03 16:00:17 14ZHGL-0000Yj-00 Child mail
process returned status 1

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
