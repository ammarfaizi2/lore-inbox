Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSGNSKM>; Sun, 14 Jul 2002 14:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSGNSKL>; Sun, 14 Jul 2002 14:10:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5905 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316996AbSGNSKK>; Sun, 14 Jul 2002 14:10:10 -0400
Date: Sun, 14 Jul 2002 19:13:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714191301.C3637@flint.arm.linux.org.uk>
References: <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz> <20020714121731.GA15055@win.tue.nl> <20020714143702.A26584@ucw.cz> <20020714173729.GA15065@win.tue.nl> <20020714200119.E27798@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020714200119.E27798@ucw.cz>; from vojtech@suse.cz on Sun, Jul 14, 2002 at 08:01:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 08:01:19PM +0200, Vojtech Pavlik wrote:
> On Sun, Jul 14, 2002 at 07:37:29PM +0200, Andries Brouwer wrote:
> > Send 0xff to port 60. Wait for the 0xfa ack. Wait for the 0xaa good status.
> 
> The problem is that 0xff takes too long to finish to be done while Linux
> is booting, and it has already been done by the BIOS.

Ah hem, "bios".  Do we trust that hunk of proprietary code now?  Note
also that pc_keyb.c allowed for embedded devices where there is no BIOS.
That said, not sending 0xff seems to be fine on the keyboards I have
here.  I wouldn't like to guarantee that it's fine across all keyboards
though, just like sending 0xAA on reconnect isn't guaranteed.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

