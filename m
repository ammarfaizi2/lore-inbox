Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbRFLOsh>; Tue, 12 Jun 2001 10:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbRFLOs2>; Tue, 12 Jun 2001 10:48:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11792 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261487AbRFLOsR>;
	Tue, 12 Jun 2001 10:48:17 -0400
Date: Tue, 12 Jun 2001 15:47:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeremy Sanders <jss@ast.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
Message-ID: <20010612154735.B17905@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk>; from jss@ast.cam.ac.uk on Tue, Jun 12, 2001 at 02:59:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 02:59:12PM +0100, Jeremy Sanders wrote:
> I'm getting numerous rsync (v2.4.6) problems under Linux 2.4.2 (RedHat
> 7.1) or stock 2.4.4 on several machines. rsync often hangs copying files
> from NFS or local disks to local disks. Strangely the problem is fixed by
> stracing one of the three rsync threads!

<aol>me too!</aol> but I got shafted because I was using 2.2.15pre13 on
the machine rsync was pushing the data to, and this was the problem.

However, I can confirm that your symptoms are _precisely_ identical to
mine - when rsync locks up, stracing it on the 2.4.2 end causes it to start
up again.

At the time I suggested it was because of a missing wakeup in 2.4.2 kernels,
but I was shouted down for using 2.2.15pre13.  Since then I've seen these
reports appear on lkml several times, each time without a solution nor
explaination.

Oh, and yes, we're still using the same setup here at work, and its running
fine now - no rsync lockups.  I'm not sure why that is. ;(

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

