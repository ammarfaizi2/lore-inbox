Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292863AbSB0SSr>; Wed, 27 Feb 2002 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292866AbSB0SSS>; Wed, 27 Feb 2002 13:18:18 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:49201 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S292867AbSB0SRx>; Wed, 27 Feb 2002 13:17:53 -0500
Message-ID: <3C7D24F9.B93D47E6@mindspring.com>
Date: Wed, 27 Feb 2002 10:27:05 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.18 and RH 7.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this has been reported as I am not on the mailing list.  I'm
guessing probably yes.

I have a RH 7.2 box and am getting the following error from iptables and
kernel 2.4.18. I don't get it in 2.4.17.

output from /etc/init.d/iptables start

Flushing all current rules and user defined chains:        [  OK  ]
Clearing all current rules and user defined chains:        [  OK  ]
iptables: libiptc/libip4tc.c:384: do_check: Assertion
`h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
/etc/init.d/iptables: line -242:  1222 Aborted                 iptables
-t $i -Fiptables: libiptc/libip4tc.c:384: do_check: Assertion
`h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
/etc/init.d/iptables: line -239:  1225 Aborted                 iptables
-t $i -Xiptables: libiptc/libip4tc.c:384: do_check: Assertion
`h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
/etc/init.d/iptables: line -235:  1228 Aborted                 iptables
-t $i -ZApplying iptables firewall rules:
iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
`h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
/etc/init.d/iptables: line -232:  1230 Done                    grep -v
"^[[:space:]]*#" $IPTABLES_CONFIG
      1231                       | grep -v '^[[:space:]]*$'
      1232 Aborted                 | /sbin/iptables-restore -c

from var/log/messages:

Feb 27 09:53:01 Lserver iptables: Flushing all current rules and user
defined chains: succeeded
Feb 27 09:53:01 Lserver iptables: Clearing all current rules and user
defined chains: succeeded
Feb 27 09:53:01 Lserver iptables: Flushing all current rules and user
defined chains: succeeded
Feb 27 09:53:01 Lserver iptables: Clearing all current rules and user
defined chains: succeeded
Feb 27 09:53:01 Lserver iptables: Applying iptables firewall rules
failed

Joe

