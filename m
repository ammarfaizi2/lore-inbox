Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135630AbRDXOBu>; Tue, 24 Apr 2001 10:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135628AbRDXOBj>; Tue, 24 Apr 2001 10:01:39 -0400
Received: from ford.balliol.ox.ac.uk ([163.1.209.24]:5248 "EHLO
	ford.balliol.ox.ac.uk") by vger.kernel.org with ESMTP
	id <S135626AbRDXOBU>; Tue, 24 Apr 2001 10:01:20 -0400
Date: Tue, 24 Apr 2001 15:00:21 +0100
From: Thomas Ford <thomas.ford@balliol.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: PIO disk writes using 100% system time and performing poorly with VIA vt82c686b on kernels 2.2 & 2.4
Message-ID: <20010424150020.A712@ford.balliol.ox.ac.uk>
Reply-To: thomas.ford@balliol.ox.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heavy disc writes (eg. unzipping linux kernel source) cause the system
processor usage (as reported by top/xosview) to jump to 100%, making
the X mouse/audio freeze etc.

Such problems occur with the drives connected to VIA vt82c686b south
bridge: the same drives on a mvp3 show no such problems.

The behaviour is the same on kernels 2.2.17 & 2.4.3 (both hand
compiled & RedHat's 2.4.2-2 & 2.2.17-14 in case I was doing something
wrong).

The problem is easily demonstrated by hdparm -t. The CPU use jumps to
system 100% as above and all my drives report ~1.9 MB/sec in PIO mode
which is far lower than PIO on the mvp3 (~10MB/s).

DMA mode appears to work fine but I am not using it due to publicised
potential problems.

Regards,

Tom Ford
