Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131653AbRC0V61>; Tue, 27 Mar 2001 16:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRC0V6R>; Tue, 27 Mar 2001 16:58:17 -0500
Received: from [64.66.225.141] ([64.66.225.141]:15877 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131627AbRC0V6D>; Tue, 27 Mar 2001 16:58:03 -0500
Date: Tue, 27 Mar 2001 15:36:01 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2: System clock slows down under load
Message-ID: <20010327153600.A6238@hapablap.dyn.dhs.org>
In-Reply-To: <Pine.WNT.4.33.0103271315310.252-101000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.WNT.4.33.0103271315310.252-101000@algeria.intern.net>; from tpfaff@gmx.net on Tue, Mar 27, 2001 at 01:42:39PM +0200
X-Uptime: 3:34pm  up  5:12,  1 user,  load average: 1.33, 1.33, 1.28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 01:42:39PM +0200, Thomas Pfaff wrote:
> Hi all,
> 
> i decided to make a test for the 2.4 kernel on my old hardware (Gigabyte
> EISA/VLB with an AMD 486 DX4 133). The kernel boots fine but there is one
> strange thing: The system clock slows down under load, after a make
> dep in the linux src directory it is about 2 minutes behind. This appears
> both in 2.4.1 and in 2.4.2 (I have not tried 2.4.0 yet).
> 
> I have attached a gzipped dmesg.
> 
> Any ideas ?

I notice that you're using fbcon from your dmesg.  There was a
discussion about this a while back, and it was determined that fbcon
runs with interrupts disabled for unhealthily long period of time.  This
causes it to miss timer interrupts, and the system lock get behind.  See
if this slowdown occurs with vgacon.  If it does, its probably just a
cheap crystal on the motherboard.

-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
