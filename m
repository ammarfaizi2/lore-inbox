Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbVJGWOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbVJGWOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 18:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbVJGWOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 18:14:17 -0400
Received: from mail.arava.co.il ([212.29.226.3]:1722 "HELO arava.co.il")
	by vger.kernel.org with SMTP id S1030556AbVJGWOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 18:14:17 -0400
Date: Sat, 8 Oct 2005 01:14:18 +0300 (IDT)
From: Matan Ziv-Av <matan@svgalib.org>
X-X-Sender: matan@matan.home
To: Dave Airlie <airlied@gmail.com>
cc: jmerkey <jmerkey@utah-nac.org>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
In-Reply-To: <21d7e9970510051646q4074813cwfa843e6ad1b7ce44@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0510080101160.13084@matan.home>
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com> 
 <87oe66r62s.fsf@amaterasu.srvr.nix>  <20051003153515.GW7992@ftp.linux.org.uk>
  <87zmpqbcws.fsf@amaterasu.srvr.nix>  <21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>
  <87br23odls.fsf@amaterasu.srvr.nix>  <21d7e9970510051557u42ae32f0rca46e951c5da536f@mail.gmail.com>
  <8764sbwoj7.fsf@amaterasu.srvr.nix>  <21d7e9970510051636g29012748o77124c1c1abc9259@mail.gmail.com>
  <43445238.5030900@utah-nac.org> <21d7e9970510051646q4074813cwfa843e6ad1b7ce44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Dave Airlie wrote:

>> How about putting the ability to disable graphics mode in the kernel and
>> moving this capability from X, and saving the video state. Would make
>> kernel debuggers work a hell of a lot better when the damn thing crashes
>> in X in the kernel. At least then the screen won;t be locked up (of
>> course you can type "reboot " from memory while the system is still hung
>> in X).

You don't need to reboot. You can use some tools to restore text 
mode - svgalib comes with three such tools, that work in large majority
of the cases:
textmode (on all platforms), mode3 and vga_reset (i386 only).

> It's been on the todo list for a long while... there's been talks at
> different events about it, there'll be a talk at LCA from me again
> about it and what has happened since KS (not a huge amount)....
>
> We've nearly all agreed on a direction, we haven't found anyone with
> the bandwidth to actually move things in that direction... (or at
> least no-one has said to me heres some money  go do this thing... :-)

I intend to put that part of svgalib in kernel (restoring modes), 
since it would make the most complicated part of svgalib -- console 
switch handling -- much simpler. The problem is that svgalib only 
handles video mode, totally ignoring 2D/3D engines, so it might


-- 
Matan Ziv-Av.                         matan@svgalib.org

