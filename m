Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129389AbRCAArK>; Wed, 28 Feb 2001 19:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129399AbRCAAq7>; Wed, 28 Feb 2001 19:46:59 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:6419 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129389AbRCAAqv>;
	Wed, 28 Feb 2001 19:46:51 -0500
Subject: Re: time drift and fb comsole activity
From: Brad Douglas <brad@neruo.com>
To: Andrew Morton <morton@nortelnetworks.com>
Cc: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
In-Reply-To: <3A9D8BC4.45009947@asiapacificm01.nt.com>
In-Reply-To: <20010228170030.C2122@sparrow.nad.adelphia.net>  
	<3A9D8BC4.45009947@asiapacificm01.nt.com>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 28 Feb 2001 16:43:49 -0800
Mime-Version: 1.0
Message-Id: <20010301004657Z129389-407+1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2001 23:37:40 +0000, Andrew Morton wrote:
> Eric Buddington wrote:
> > 
> > I know this has been reported on the list recently, but I think I can
> > provide better detail. I'm running 2.4.2 with atyfb on a K6-2/266
> > running at 250. This system has no history of clock problems.
> > 
> > adjtimex-1.12 --compare gives me "2nd diff" readings of -0.01 in quiescent
> > conditions.
> > 
> > flipping consoles rapidly cboosts this number to -3 or -4.
> > 
> > catting the full documentation to ntpd (seemed appropriate) gives me
> > "2nd diff" numbers a little over 34. If I read the numbers correctly,
> > 47 seconds of CMOS time passed while the system clock only passed 13
> > seconds.
> > 
> > The processor and the CMOS clock were moving at zero velocity relative
> > to each other, and were both in normal Earth gravity.
> 
> The kernel blocks interrupts during console output.  fbdev
> consoles are slow.  Net result: many lost timer interrupts.
> 
> I'm working on it.  Slowly.  Should have something next week.

You may want to check out the linuxconsole project on Sourceforge.  I
believe one of their goals is to remove/minimize the console lock...

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org


