Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSEWJVZ>; Thu, 23 May 2002 05:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316431AbSEWJVY>; Thu, 23 May 2002 05:21:24 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:28357 "EHLO fep2.cogeco.net")
	by vger.kernel.org with ESMTP id <S314278AbSEWJVX>;
	Thu, 23 May 2002 05:21:23 -0400
Subject: Reset PCI card
From: "Nix N. Nix" <nix@go-nix.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 May 2002 05:21:23 -0400
Message-Id: <1022145683.21661.15.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The symptom:

Sometimes, when I switch between virtual terminals, (away from X ==
tty7), instead of getting my usual login prompt, the picture I've had
during my X session (or the picture of the display manager) stays on the
screen, albeit with some of the colours screwed up (as if it were a 256
colour palette-based display, even though it's 24 bit colour - you know,
like in Windows, when you have 256 colours and you switch from one app
to another and the colours in your background picture get all frelled
up).  The terminal does switch over to the appropriate tty because I can
log in and type whatever (blindly though) and it does work.

The problem:

There is no way to somehow reset my video card so that it once again
switches between X and console mode correctly.

The question:

Is there any way of fooling an AGP card (or a PCI card) into believing
that the computer has been powercycled/rebooted/whatever ? 
Alternatively, is there any other approach to fixing this problem (==
getting my consoles back) ?  I have no frame buffer devices compiled
into the kernel (vanilla 2.4.18).  This problem seems to be video card
independent and it seems that starting multiple X servers tends to
precipitate this problem.  So far, I have experienced it with
NVidia(AGP, has DRI), Voodoo5/5500(PCI, has DRI), ATI Rage Mobility P/M
(AGP-Laptop, no DRI).
It's as if the video card all of a sudden refused to switch modes from
1024x768x24 to console and back.

The solution:
The only solution I could find (obviously unsatisfactory) is to reboot. 
Hence my question:  I'd like to fool the card into thinking I've
rebooted, or otherwise get it switching modes again.



Thanks for your attention.

