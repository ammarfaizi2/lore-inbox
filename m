Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132178AbQLLRHi>; Tue, 12 Dec 2000 12:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132216AbQLLRH2>; Tue, 12 Dec 2000 12:07:28 -0500
Received: from [216.161.55.93] ([216.161.55.93]:8177 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S132178AbQLLRHM>;
	Tue, 12 Dec 2000 12:07:12 -0500
Date: Tue, 12 Dec 2000 08:38:12 -0800
From: Greg KH <greg@wirex.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
Message-ID: <20001212083812.A9287@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	"Mohammad A. Haque" <mhaque@haque.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A3623C6.B2499D4D@haque.net> <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net>; from mhaque@haque.net on Tue, Dec 12, 2000 at 09:34:30AM -0500
X-Operating-System: Linux 2.2.18-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 09:34:30AM -0500, Mohammad A. Haque wrote:
> Someone gave me a really awesome idea about possibly using a palm pilot
> to capture the oops. Anyone know if it will be a problem using
> /dev/ttyUSB0 as the serial port?
> 
> Baiscally if I want to duplicate the environment in which I'm getting
> the oops, I need to be dialed out. That takes out COM1. I never gt my
> COM2 to work (can't figure out what's wrong. doesn't work under windows
> either). So that's out. I have a Keyspan USB PDA adapter that I use for
> my Palm Vx which shows up as /dev/ttyUSB0.
> 
> I guess if usb serial can't be used I'll try duplicating the oops w/o
> being dialed out.

I don't know if /dev/ttyUSBX would work, but I think it would.  People
have successfully run consoles through the usb-serial drivers, but I'm
not sure if the oops main console requires something different (like
registering itself actually as a console?)

And then there's the nice problem of the fact that if the oops comes
from the USB code, you will not see it come out the usb-serial driver :)

Let me know if you try this, and have any success (or find that it
doesn't work.)

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
