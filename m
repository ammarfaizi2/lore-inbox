Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSLPAZd>; Sun, 15 Dec 2002 19:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSLPAZd>; Sun, 15 Dec 2002 19:25:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263491AbSLPAZc>;
	Sun, 15 Dec 2002 19:25:32 -0500
Date: Mon, 16 Dec 2002 00:33:27 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Cc: rth@twiddle.net
Subject: 2 (minor) Alpha probs in 2.5.51
Message-ID: <20021216003327.GC709@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 00:25:20 up  7:52,  2 users,  load average: 0.00, 0.01, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This is with rth's exception patch to fix the mount problem).

1) If compiled for the LX164 platform it is missing a number of symbols
at link time (fine if built generic):

arch/alpha/kernel/built-in.o(.data+0x3030): undefined reference to
`cia_bwx_inb'
arch/alpha/kernel/built-in.o(.data+0x3038): undefined reference to
`cia_bwx_inw'
.
.
.
(and a handful more)

2) This is a kind of subtle one.  Straight after boot up if I run 'w'
or 'top' I get the warning:

Unknown HZ value! (831) Assume 1024.

This value creeps up:

Unknown HZ value! (958) Assume 1024.

over a period of a few minutes till the warning goes away.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
