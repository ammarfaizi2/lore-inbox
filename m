Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTITQii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTITQii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 12:38:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261903AbTITQih
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 12:38:37 -0400
Date: Sat, 20 Sep 2003 17:38:35 +0100
From: "Dr. David Alan Gilbert" 
	<gilbertd@arentwildcardswonderfulforspammers.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2[12] v VIA Rhine and VIA82x audio (working with a fight)
Message-ID: <20030920163835.GA723@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 16:53:13 up  5:22,  1 user,  load average: 0.11, 0.28, 0.25
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I thought I'd report some problems (and solutions) I had getting
2.4.21 and 2.4.22 up on a Shuttle Motherboard using a VIA chipset.  

1) Ether

  The motherboard has onboard via-rhine ether; this wouldn't work
with the first kernels I tried.  With 2.4.22 it needs the 'noapic'
option to work (2.4.22 wouldn't build for me single processor).
The errors are timeouts on transmit; the same happens on 2.4.21

2) Audio

This was much more of a fight. The standard 2.4.21/22 via82xxx drivers
were very problematic.  For example random hanging apps, buzzing when
an app had sound open but wasn't actually sending stuff, and a complete
failure to have any sound input.

In the end I gave up and got ALSA 0.9.6; which seems to work fine for
generated audio and audio input.
Except for playing CDs - which don't do anything - I suspect that might
be hardware, but am not sure.

lspci and any other debug available on request.

Dave (linux @ treblig.org)


 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
