Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbRFLPBU>; Tue, 12 Jun 2001 11:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbRFLPBK>; Tue, 12 Jun 2001 11:01:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10396 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261639AbRFLPBB>;
	Tue, 12 Jun 2001 11:01:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15142.11907.782662.581523@pizda.ninka.net>
Date: Tue, 12 Jun 2001 08:00:19 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jeremy Sanders <jss@ast.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
In-Reply-To: <20010612154735.B17905@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk>
	<20010612154735.B17905@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > At the time I suggested it was because of a missing wakeup in 2.4.2 kernels,
 > but I was shouted down for using 2.2.15pre13.  Since then I've seen these
 > reports appear on lkml several times, each time without a solution nor
 > explaination.
 > 
 > Oh, and yes, we're still using the same setup here at work, and its running
 > fine now - no rsync lockups.  I'm not sure why that is. ;(

Look everyone, it was determined to be a deadlock because of some
interaction between how rsync sets up it's communication channels
with the ssh subprocess, readas: userland bug.

I don't remember if the specific problem was in rsync itself or some
buggy version of ssh.  One can search the list archives to discover
Alexey's full analysis of the problem.  I don't have a URL handy.

Later,
David S. Miller
davem@redhat.com
