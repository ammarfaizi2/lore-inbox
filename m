Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263370AbRFNQdW>; Thu, 14 Jun 2001 12:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbRFNQdN>; Thu, 14 Jun 2001 12:33:13 -0400
Received: from ns.tasking.nl ([195.193.207.2]:33552 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S263359AbRFNQdB>;
	Thu, 14 Jun 2001 12:33:01 -0400
Date: Thu, 14 Jun 2001 18:31:35 +0200
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5: swap/VM strangeness
Message-ID: <20010614183135.A16418@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A PIII with 96MB ram became extremely sluggish inside X11. I managed
to terminate the X server, bringing the system in a useful state
again. While the system was completely quiet (no X server) I noticed
that a lot of both memory and swap was being used for no appearent reason:

# free 
             total       used       free     shared    buffers     cached
Mem:         93692      85164       8528          0       1404      75252
-/+ buffers/cache:       8508      85184
Swap:       133048      54944      78104

# swapoff -a
	(took a minute)

# free
             total       used       free     shared    buffers     cached
Mem:         93692      41760      51932          0       1420      24828
-/+ buffers/cache:      15512      78180
Swap:            0          0          0

# swapon -a
# free
             total       used       free     shared    buffers     cached
Mem:         93692      41852      51840          0       1420      24848
-/+ buffers/cache:      15584      78108
Swap:       133048          0     133048


It looks as if the swap partition is being cached in main memory.

-- 
Frank
