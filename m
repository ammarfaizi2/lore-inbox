Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTFPMpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTFPMpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:45:34 -0400
Received: from netti-3-321.dyn.nic.fi ([212.38.238.66]:65519 "EHLO
	polaris.relay") by vger.kernel.org with ESMTP id S263786AbTFPMpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:45:33 -0400
Message-Id: <200306161259.h5GCxBj04115@polaris.relay>
Content-Type: text/plain; charset=US-ASCII
From: Jan Knutar <jk-lkml@sci.fi>
To: pnystrom@netmagic.net
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
Date: Mon, 16 Jun 2003 15:56:33 +0300
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <1055722972.1502.39.camel@spike.sunnydale> <1055728825.1482.8.camel@spike.sunnydale> <1055731591.2028.4.camel@spike.sunnydale>
In-Reply-To: <1055731591.2028.4.camel@spike.sunnydale>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The hard crash occurs only when magicdev is running.  I tried turning
> off all my preferences for auto- mounting, running, and playing
> data/audio cds in my preferences, and voila!  cdrecord works without
> a hiccup in X too.

Exactly the same experiences here, with 2 different motherboards and 2 
different CD-RW drives, with various stock kernels since 2.4.9 or so. 
Exactly the same resolution too, kill magicdev, and everything works 
fine.

My machine would sometimes survive slightly longer, usually locking up 
during fixating a disc. It would typically spit out massive amounts of 
SCSI and IDE errors, while effectively locking up the machine for, what 
at first was about 10 seconds at a time with a split second in an 
unlocked state, but that would eventually worsen into a permanently 
hard-locked state. 

Curiously enough, doing hdparm -y /dev/hdb (the cd burner), during one 
of those split second unlocked states, would usually save the system. 
It became standard practice for me to have an xterm su'd, in focus and 
ready with "hdparm -y /dev/hdb" in it, while wiggling the mouse to see 
when the pointer would freeze, to hit enter when/if it unfroze again 8-)
