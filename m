Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283766AbRLISyj>; Sun, 9 Dec 2001 13:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283761AbRLISy3>; Sun, 9 Dec 2001 13:54:29 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:40357 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S283760AbRLISyX>;
	Sun, 9 Dec 2001 13:54:23 -0500
Date: Sun, 09 Dec 2001 18:54:20 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Hudson <home@alexhudson.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: APM woes: IBM T20 Thinkpad
Message-ID: <1115759247.1007924059@[195.224.237.69]>
In-Reply-To: <1007853635.584.0.camel@lapland>
In-Reply-To: <1007853635.584.0.camel@lapland>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

--On Saturday, 08 December, 2001 11:20 PM +0000 Alex Hudson 
<home@alexhudson.com> wrote:

> I'm running a self-compiled Linux 2.4.16-pre1 on a IBM-T20, and am
> seeing problems with APM.
...
> If someone could point out some tests I could try to pin this down, or
> has some other suggestion, I would be very grateful.

This is what I did to try and get a T23 to work (which isn't
a T20, I know).

First upgrade your BIOS and/or system controller - available
FOC from the IBM web site.

If that doesn't fix it, try changing whether or not interrupts
are allowed during suspend. I think for a T20 they should *not*
be, but the T23 crashes if they are *not* (and needs it the
other way around). Don't just fiddle with the config option as
pci_quirks will override it. Either look at doing something like
  http://www.alex.org.uk/T23/T23-apm-patch.txt
or just frig the code yourself to force apm.allow_ints one way
or another.

--
Alex Bligh
