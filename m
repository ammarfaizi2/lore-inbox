Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSJNLdS>; Mon, 14 Oct 2002 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSJNLdS>; Mon, 14 Oct 2002 07:33:18 -0400
Received: from mario.gams.at ([194.42.96.10]:26202 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S261584AbSJNLdR> convert rfc822-to-8bit;
	Mon, 14 Oct 2002 07:33:17 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: linux-kernel@vger.kernel.org
Subject: open("/dev/ttyS1", O_LARGEFILE) blocks
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 14 Oct 2002 13:39:07 +0200
Message-ID: <2379.1034595547@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Is is normal/correct/intended that an open() of /dev/ttyS1 blocks?
----  snip  ----
{81}strace ./test-open /dev/ttyS0
[...]
open("/dev/ttyS0", O_RDONLY|O_NONBLOCK) = 3
close(3)                                = 0
open("/dev/ttyS0", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
_exit(0)                                = ?
{82}strace ./test-open /dev/ttyS1
[...]
open("/dev/ttyS1", O_RDONLY|O_NONBLOCK) = 3
close(3)                                = 0
open("/dev/ttyS1", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/ttyS1", O_RDONLY|O_LARGEFILE <unfinished ...>
{83}lsof /dev/ttyS0
{84}lsof /dev/ttyS1
{85}uname -a
Linux xxx 2.4.20-pre10aa1 #6 Fri Oct 11 13:41:20 CEST 2002 i686 unknown
----  snip  ----

The second one was terminated with a Ctrl-C.
Nothing was connected to none of the ports.
Is there a reason that an open() on /dev/ttyS0 works and blocks
on /dev/ttyS1?

	Bernd

-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


