Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSGNSO3>; Sun, 14 Jul 2002 14:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSGNSO2>; Sun, 14 Jul 2002 14:14:28 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:25526 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316997AbSGNSO1>;
	Sun, 14 Jul 2002 14:14:27 -0400
Date: Sun, 14 Jul 2002 20:17:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714201711.A30723@ucw.cz>
References: <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz> <20020714121731.GA15055@win.tue.nl> <20020714143702.A26584@ucw.cz> <20020714173729.GA15065@win.tue.nl> <20020714200119.E27798@ucw.cz> <20020714191301.C3637@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020714191301.C3637@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Jul 14, 2002 at 07:13:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 07:13:01PM +0100, Russell King wrote:

> On Sun, Jul 14, 2002 at 08:01:19PM +0200, Vojtech Pavlik wrote:
> > On Sun, Jul 14, 2002 at 07:37:29PM +0200, Andries Brouwer wrote:
> > > Send 0xff to port 60. Wait for the 0xfa ack. Wait for the 0xaa good status.
> > 
> > The problem is that 0xff takes too long to finish to be done while Linux
> > is booting, and it has already been done by the BIOS.
> 
> Ah hem, "bios".  Do we trust that hunk of proprietary code now?  Note
> also that pc_keyb.c allowed for embedded devices where there is no BIOS.
> That said, not sending 0xff seems to be fine on the keyboards I have
> here.  I wouldn't like to guarantee that it's fine across all keyboards
> though, just like sending 0xAA on reconnect isn't guaranteed.

Well, so far I've tested with about 20 different weird keyboards ...
let's see. If the future shows we need 0xff, there's no problem adding
it.

-- 
Vojtech Pavlik
SuSE Labs
