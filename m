Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbRE0VoB>; Sun, 27 May 2001 17:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbRE0Vnv>; Sun, 27 May 2001 17:43:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262406AbRE0Vnh>;
	Sun, 27 May 2001 17:43:37 -0400
Date: Sun, 27 May 2001 22:42:57 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Abramo Bagnara <abramo@alsa-project.org>, davem@caip.rutgers.edu,
        anton@linuxcare.com.au, Ralf Baechle <ralf@oss.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
Message-ID: <20010527224257.B2702@flint.arm.linux.org.uk>
In-Reply-To: <3B115279.CE436CEA@alsa-project.org> <Pine.NEB.4.33.0105272301280.8551-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.NEB.4.33.0105272301280.8551-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Sun, May 27, 2001 at 11:07:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 11:07:38PM +0200, Adrian Bunk wrote:
> I do also explicitely send this mail to the people that seem to be
> responsible for the pieces of code I touch.
> 
> I'm not sure whether the compete removal of the "#ifdef __KERNEL__"'s is
> too rude but there are already other architectures that don't have it in
> their architecture specific versions of these files.

You cannot use the kernel atomic/interrupt functions from userspace
on ARM.  You cannot disable interrupts in userspace, and therefore the
kernel atomic functions do not work as you expect them to.

If it is to do with code to be included into the kernel, then why aren't
you defining __KERNEL__ ?

Therefore this change (as far as ARM goes) makes zero sense.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

