Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279592AbRJ2XLa>; Mon, 29 Oct 2001 18:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279593AbRJ2XLW>; Mon, 29 Oct 2001 18:11:22 -0500
Received: from t08-12.ra.uc.edu ([129.137.228.180]:4224 "EHLO cartman")
	by vger.kernel.org with ESMTP id <S279592AbRJ2XLM>;
	Mon, 29 Oct 2001 18:11:12 -0500
Date: Mon, 29 Oct 2001 18:10:29 -0500
To: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: 8139too termination
Message-ID: <20011029181029.A320@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Robert Kuebel <kuebelr@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have been getting this message at shutdown ...

"eth1: unable to signal thread"

it turns out that 8139too's kernel thread gets killed at shutdown (or
reboot) when SIGTERM is sent to all processes.  then the network
shutdown script comes along and takes down the interface.  the driver
complains ...

"eth1: unable to signal thread"

because the thread has already terminated.  the driver currently does
not block any signals.

my question is, should 8139too really not block any signals (and allow
itself to be killed by them)?  isn't it a bad thing to allow a kernel
thread to be killed accidentally like this?

give me some feedback.  i would be happy to write a fix.

also, please cc me on replies.  i can only handle the digest form of
lkml.

thanks.
rob.

