Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278643AbRJSUHK>; Fri, 19 Oct 2001 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278644AbRJSUHB>; Fri, 19 Oct 2001 16:07:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11505
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278643AbRJSUGo>; Fri, 19 Oct 2001 16:06:44 -0400
Date: Fri, 19 Oct 2001 13:07:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bad name/docs: "Forwarding between high speed interfaces"
Message-ID: <20011019130712.H2467@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This option enables NIC (Network Interface Card) hardware throttling
  during periods of extremal congestion. At the moment only a couple
  of device drivers support it (really only one -- tulip, a modified
  8390 driver can be found at
  ftp://ftp.inr.ac.ru/ip-routing/fastroute/fastroute-8390.tar.gz ). 
  
  Really, this option is applicable to any machine attached to a fast
  enough network, and even a 10 Mb NIC is able to kill a not very slow
  box, such as a 120MHz Pentium.
    
  However, do not say Y here if you did not experience any serious
  problems.

This doesn't look too incouraging.  Until I read the whole 150+ message
thread about IRQ throtling, I thought it had something to do with ethernet
bridging at high load.

I'm not surprised that this option has been overlooked.

I think the Configure.help message should be something like:

This option enables NIC (Network Interface Card) hardware throttling
during periods high load. 

Without this option, a fast NIC, fast network, and a slow computer can get
enough pp/s (packets per second) to provide an effective DoS attack.  (This
has been reported to be possible with a 10Mbps ethernet NIC on a Pentium
120Mhz)

At the moment only a few device drivers support it (At the moment, only
tulip, and  a modified 8390 - specifically NE2000/1000 - driver that can be
found at ftp://ftp.inr.ac.ru/ip-routing/fastroute/fastroute-8390.tar.gz).

Hopefully more drivers will support this feature soon.

=================

I took a look at fastroute-8390.tar.gz, and it seems to be a driver written
by Donald Becker from way back in '94.  If so, it's probably 2.2 only, and
should be taken out of the 2.4 documentation.
