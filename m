Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289435AbSAJNPh>; Thu, 10 Jan 2002 08:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289437AbSAJNPT>; Thu, 10 Jan 2002 08:15:19 -0500
Received: from lummi.dev.valueweb.com ([216.219.250.201]:31797 "HELO
	lummi.dev.valueweb.com") by vger.kernel.org with SMTP
	id <S289435AbSAJNPD>; Thu, 10 Jan 2002 08:15:03 -0500
Date: Thu, 10 Jan 2002 08:15:02 -0500
From: Donnie Roberts <donnier@valueweb.com>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard + PS/2 mouse locks after opening psaux
Message-ID: <20020110081502.A31027@lummi.dev.valueweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a Tyan Tiger K7 and experienced a similar problem. The
keyboard locked up when gpm started, but it came back after I
stopped gpm (by logging in remotely). I discovered in my BIOS that
the mouse was configured to "Automatic". Changing it to "Enabled"
fixed my problem.

I suggest checking your BIOS for anything related to the mouse. It
could be occurring because the interrupt is not getting assigned
for the mouse by the BIOS, or something to that effect. That is
what my thoughts are on this problem. After seeing reports of the
interrupt counts in /proc/interrupts not being updated while the
mouse (/dev/psaux) is opened, it made me think that it could be an
IRQ problem.
