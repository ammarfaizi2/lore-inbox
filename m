Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265159AbUAHPdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUAHPdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:33:24 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:62936 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S265159AbUAHPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:33:18 -0500
Message-ID: <3FFD786F.7090501@oracle.com>
Date: Thu, 08 Jan 2004 16:34:07 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, users@lists.ximian.com
Subject: timing issues with Ximian Desktop 2 and kernel 2.6.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XD2-latest, 2.6.1-rc3 as of now, RH9 as base distro; also using
  synaptics_drv.o from the 0.12.2 tarball, Radeon 7500 card.


The startup sequence of XD2 seems to hit a timing issue with 2.6.x
  kernels so that the top panel's applet icons aren't displayed in
  the panel itself.
That however is a minor problem - the big one is that if I don't
  go right-clicking the panel in some 10 seconds (which makes the
  icons appear, btw) my CPU usage goes to 100% with these in 'top':

64 processes: 62 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  67.9% user  32.0% system   0.0% nice   0.0% iowait   0.0% idle
Mem:  1033892k av,  207756k used,  826136k free,       0k shrd,   15052k buff
        128844k active,              47412k inactive
Swap:  514040k av,       0k used,  514040k free                  109240k cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
  2327 asuardi   25   0 15648 6428 14972 R    27.9  0.6   0:04   0 notification-ar
  2271 root      15   0 63732  15M 51256 S    25.1  1.5   0:04   0 X
  2320 asuardi   15   0 15300 5236 14848 S    23.7  0.5   0:03   0 pam-panel-icon
  2313 asuardi   15   0 19696  11M 16988 S    21.5  1.1   0:03   0 gnome-panel
  2258 root      17   0  3932 1064  3788 R     0.9  0.1   0:00   0 top
  2322 asuardi   15   0 15588 6512 14916 S     0.1  0.6   0:00   0 gnome-cups-mana
     1 root      16   0  1380  480  1344 S     0.0  0.0   0:07   0 init
     2 root      34  19     0    0     0 SWN   0.0  0.0   0:00   0 ksoftirqd/0
     3 root       5 -10     0    0     0 SW<   0.0  0.0   0:00   0 events/0
     4 root       5 -10     0    0     0 SW<   0.0  0.0   0:00   0 kblockd/0
     5 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 khubd
     6 root      25   0     0    0     0 SW    0.0  0.0   0:00   0 pdflush

[NB: the first process is notification-area-applet]

  and the desktop is only partially usable (it is still possible to
  have the root window menu activated, but nothing else apparently).

Eventually this leads to a stage where you can only Ctrl-Alt-Bksp
  out of X (or Alt-Fn to a console and kill the spinning processes).


If instead I'm not too slow and I prod the panel with a right-click
  on it, nothing of this happens and the desktop is as happy as with
  a 2.4.x kernel under the hood.


Since this is 100% reproducable and very easily, I'm available for
  testing and providing further info.

Thanks in advance, ciao,

--alessandro

  "Immagina intensamente e vedrai
    dove gli altri pensano che non ci sia niente"
       (Cristina Dona', "Salti nell'aria")


