Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135569AbRDSXLE>; Thu, 19 Apr 2001 19:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135751AbRDSXKy>; Thu, 19 Apr 2001 19:10:54 -0400
Received: from [209.250.53.143] ([209.250.53.143]:25093 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S135569AbRDSXKr>; Thu, 19 Apr 2001 19:10:47 -0400
Date: Thu, 19 Apr 2001 18:10:29 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in serial.c
Message-ID: <20010419181028.A5462@hapablap.dyn.dhs.org>
In-Reply-To: <25369470B6F0D41194820002B328BDD27C8E@ATLOPS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25369470B6F0D41194820002B328BDD27C8E@ATLOPS>; from marc_karasek@ivivity.com on Thu, Apr 19, 2001 at 11:32:20AM -0400
X-Uptime: 6:06pm  up  3:00,  1 user,  load average: 1.45, 1.30, 1.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 11:32:20AM -0400, Marc Karasek wrote:
> I am doing some embedded development with the 2.4.x series and have noticed
> a few things..
> 
> 1) In 2.4.2 in order to compile with module support you also had to turn on
> smp support.  This has been fixed in the 2.4.3 release.  This bloated the
> kernel image to 600k+ which in an embedded world is not a good thing :-)
> 
> 2) In 2.4.3 the console port using ttySX is broken.  It dumps fine to the
> terminal but when you get to a point of entering data (login, configuration
> scripts, etc) the terminal does not accept any input.  
> 
> So far I have been able to debug to the point where I see that the kernel is
> receiving the characters from the serial.c driver.  But it never echos them
> or does anything else with them.  I will continue to look into this at this
> end.  
> 
> I was also wondering if anyone else has seen this or if a patch is avail for
> this bug??

Just a "me, too!" here.  I've seen some symptoms very similar to this
with the same kernel version.  When I try to run a getty a tty which is
also the console (not sure what happens if it isn't a console) it
freezes up and doesn't respond or echo kernels.  Works on 2.4.2, just
like yours.

>From an strace of getty, it appears to be hanging in ioctl(..., TCSETSW
I hope this gets resolved.  Its more than a little irritating.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
