Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbRHFNph>; Mon, 6 Aug 2001 09:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268497AbRHFNp2>; Mon, 6 Aug 2001 09:45:28 -0400
Received: from lech.pse.pl ([194.92.3.7]:56712 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S266982AbRHFNpW>;
	Mon, 6 Aug 2001 09:45:22 -0400
Date: Mon, 6 Aug 2001 15:45:30 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getty problems
Message-ID: <20010806154530.A26776@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010806142703.A25428@lech.pse.pl> <20010807003043.C23937@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010807003043.C23937@weta.f00f.org>
User-Agent: Mutt/1.3.20i
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     open("/dev/tty9", O_RDWR|O_NONBLOCK)    = -1 ENODEV (No such device)
>     
>     And yes, I believe I have terminal support compiled in:
> 
> /prox/devices says?

2.4.5:
------

 Character devices:
   1 mem
   2 pty/m%d
   3 pty/s%d
   4 tts/%d
   5 cua/%d
   6 lp
   7 vcs
  10 misc
  21 sg
  29 fb
 108 ppp
 109 lvm
 128 ptm
 129 ptm
 136 pts/%d
 137 pts/%d
 162 raw

 /proc/tty/drivers

 serial               /dev/cua/%d     5  64-127 serial:callout
 serial               /dev/tts/%d     4  64-127 serial
 pty_slave            /dev/pts/%d   137   0-255 pty:slave
 pty_master           /dev/ptm      129   0-255 pty:master
 pty_slave            /dev/pts/%d   136   0-255 pty:slave
 pty_master           /dev/ptm      128   0-255 pty:master
 pty_slave            /dev/pty/s%d    3   0-255 pty:slave
 pty_master           /dev/pty/m%d    2   0-255 pty:master
 /dev/vc/0            /dev/vc/0       4       0 system:vtmaster
 /dev/ptmx            /dev/ptmx       5       2 system
 /dev/console         /dev/console    5       1 system:console
 /dev/tty             /dev/tty        5       0 system:/dev/tty
 unknown              /dev/vc/%d      4    1-63 console

2.4.7-ac7:
----------

 /proc/devices

 Character devices:
   1 mem
   2 pty
   3 ttyp
   4 ttyS
   5 cua
   7 vcs
  10 misc
 128 ptm
 136 pts
 162 raw

 /proc/tty/drivers

 serial               /dev/cua        5  64-127 serial:callout
 serial               /dev/ttyS       4  64-127 serial
 pty_slave            /dev/pts      136   0-255 pty:slave
 pty_master           /dev/ptm      128   0-255 pty:master
 pty_slave            /dev/ttyp       3   0-255 pty:slave
 pty_master           /dev/pty        2   0-255 pty:master
 /dev/vc/0            /dev/vc/0       4       0 system:vtmaster
 /dev/ptmx            /dev/ptmx       5       2 system
 /dev/console         /dev/console    5       1 system:console
 /dev/tty             /dev/tty        5       0 system:/dev/tty


-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
