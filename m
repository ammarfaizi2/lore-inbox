Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTIZA0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 20:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTIZA0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 20:26:17 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:5234 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262081AbTIZA0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 20:26:16 -0400
Date: Thu, 25 Sep 2003 21:26:05 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Zombie process with preemptible enabled.
Message-Id: <20030925212605.0c4baa57.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

Since i starting to testing 2.6 and recently mm and -ck, i see that Mozilla/Mozilla Firebird
(diferent versions) launch a netstat child that when finalize, it remain zombie. It only happens
when preemptible option is enabled.

The kernel version has tested is:
2.6.0-test[12345]
2.6.0-test5-mm4
2.4.22-ck2.

For example:
456 ?        S      0:00 /bin/sh /usr/local/lib/mozilla-1.5a/run-mozilla.sh /u
463 ?        S      0:48  \_ /usr/local/lib/mozilla-1.5a/MozillaFirebird-bin
490 ?        Z      0:00      \_ [netstat <defunct>]

The file /proc/490/wchan shows do_exit.

Closing Mozilla kill the zombie.

more info need?

http://www.vmlinuz.com.ar/slackware/kernel.config.djgera/config-2.4.22-ck2
http://www.vmlinuz.com.ar/slackware/kernel.config.djgera/config-2.6.0-test5
http://www.vmlinuz.com.ar/slackware/kernel.config.djgera/config-2.6.0-test5-mm4

Disabling preemptible solves the problem in all cases.

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
