Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129997AbQLGNJv>; Thu, 7 Dec 2000 08:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbQLGNJb>; Thu, 7 Dec 2000 08:09:31 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:64017 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129997AbQLGNJW>;
	Thu, 7 Dec 2000 08:09:22 -0500
Date: Thu, 7 Dec 2000 13:38:21 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [PATCH] New user space serial port driver
Message-ID: <20001207133821.A9656@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0011300903470.11226-100000@panoramix.bitwizard.nl> <20001202225909.B6988@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001202225909.B6988@bug.ucw.cz>; from pavel@suse.cz on Sat, Dec 02, 2000 at 10:59:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Please consider including this user space serial driver. It was writen for
> > the Pele 833 RAS Server but is also usable for other serial device drivers
> > in user space.
> 
> Good, someone finally implemented this. This is going to be mandatory
> if we want to support winmodems properly; also ISDN people might be
> interested [to kick AT emulation out of kernel].

For winmodems you can do a pretty good job with ptys -- the pty and tty
side access the same share termios structure.  The new driver is a
much cleaner way to the same functionality though.  (Conceptually; I
looked at the API summary but haven't looked at the code).

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
