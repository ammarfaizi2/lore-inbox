Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSGNK3d>; Sun, 14 Jul 2002 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSGNK3c>; Sun, 14 Jul 2002 06:29:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45583 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315758AbSGNK3c>; Sun, 14 Jul 2002 06:29:32 -0400
Date: Sun, 14 Jul 2002 11:32:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714113220.A2693@flint.arm.linux.org.uk>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020714101854.GA1068@wizard.com>; from tyketto@wizard.com on Sun, Jul 14, 2002 at 03:18:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 03:18:54AM -0700, A Guy Called Tyketto wrote:
> mice: PS/2 mouse device common for all mice
> atkbd.c: Sent: f5
> atkbd.c: Received fe
> serio: i8042 KBD port at 0x60,0x64 irq 1

I've seen this when I was first looking into the input stuff recently.
I think it was caused by the keyboard getting confused after I was
testing the data and clock lines on the interface.

One fix I came up with (and discarded) was to try to reset the keyboard
3 times, and only fail if it failed all 3 times.  The other fix (the one
I ended up using) doesn't make sense to i8042 keyboard controllers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

