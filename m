Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265857AbUFOSwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265857AbUFOSwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUFOSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:52:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19972 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265857AbUFOSwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:52:09 -0400
Date: Tue, 15 Jun 2004 19:52:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: foo@porto.bmb.uga.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: more about serial console
Message-ID: <20040615195205.D7666@flint.arm.linux.org.uk>
Mail-Followup-To: foo@porto.bmb.uga.edu, linux-kernel@vger.kernel.org
References: <20040615000436.GA12516@porto.bmb.uga.edu> <20040615184229.GA13604@porto.bmb.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615184229.GA13604@porto.bmb.uga.edu>; from foo@porto.bmb.uga.edu on Tue, Jun 15, 2004 at 02:42:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:42:29PM -0400, foo@porto.bmb.uga.edu wrote:
> On Mon, Jun 14, 2004 at 08:04:36PM -0400, foo@porto.bmb.uga.edu wrote:
> > The other weird thing I have seen is with the serial console.  After
> > init loads the net bonding module and the network comes up, the serial
> > console output stops, as though I had typed ^s.  If I type a character
> > (doesn't seem to matter what), instead of that character printing I see
> > the next character of console output.  I have to hold down a key for a
> > few seconds to get the next few lines of output, then it starts printing
> > on its own again.  I've seen this with 2.6.7-rc3-bk4 and 2.6.6, not with
> > 2.6.5 (I booted 2.6.6 by accident yesterday, I don't know how it does
> > with NFS).
> 
> More experience with 2.6.7-rc3-bk6: this is basically the same, although
> the console stalled twice during one boot, once after mounting all the
> filesystems and then again after the ethernet comes up (as always).
> 
> Also, I was wrong about getting one character of output for each that I
> type - it looks like I get 16 characters (if that many are available to
> be printed, seemingly).

So it only happens when userspace is using the serial port and a few
other things are in use.

Is anything sharing the serial port's interrupt?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
