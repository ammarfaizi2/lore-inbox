Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278551AbRJ3Wxe>; Tue, 30 Oct 2001 17:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278597AbRJ3WxZ>; Tue, 30 Oct 2001 17:53:25 -0500
Received: from marine.sonic.net ([208.201.224.37]:25949 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S278551AbRJ3WxN>;
	Tue, 30 Oct 2001 17:53:13 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 30 Oct 2001 14:53:40 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
Message-ID: <20011030145340.A2024@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011029124753.F21285@one-eyed-alien.net> <4.3.2.7.2.20011029172525.00bb2270@mail.osagesoftware.com> <3BDDE642.8000901@acm.org> <3BDE6A80.3A68A44E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDE6A80.3A68A44E@mvista.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 12:53:20AM -0800, george anzinger wrote:
> Jonathan Briggs wrote:
> > A 32 bit uptime patch should also include a new kernel parameter that
> > could be passed from LILO: uptime.  Then you could test the uptime patch
> > by passing uptime=4294967295
> 
> NO NO NO!  
> 
> First uptime is a conversion of jiffies.  Second, the POSIX standard
> wants a CLOCK_MONOTONIC which, by definition, can not be set.  Jiffies

I believe that at least some SVR4 systems allow you to set lbolt, either
during runtime or at boot.

You have to be able to do that to test things.  Like drivers (last I check,
NCR still crashes upon wrap around), or utilities that monitor the uptime
so they can remind you that a reboot is necessary soon (so that you don't
crash).

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
