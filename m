Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271276AbRH3DhT>; Wed, 29 Aug 2001 23:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271288AbRH3DhJ>; Wed, 29 Aug 2001 23:37:09 -0400
Received: from [209.250.53.22] ([209.250.53.22]:43794 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S271276AbRH3Dg6>; Wed, 29 Aug 2001 23:36:58 -0400
Date: Wed, 29 Aug 2001 22:36:10 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Robert Lowery <Robert.Lowery@colorbus.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Slightly OT]  Where should SIS 6326 mpeg2 hardware acceleration code live?
Message-ID: <20010829223610.A4472@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Robert Lowery <Robert.Lowery@colorbus.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <370747DEFD89D2119AFD00C0F017E6614A62CF@cbus613-server4.colorbus.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <370747DEFD89D2119AFD00C0F017E6614A62CF@cbus613-server4.colorbus.com.au>; from Robert.Lowery@colorbus.com.au on Thu, Aug 30, 2001 at 10:18:52AM +1000
X-Uptime: 4:16pm  up 2 days, 22:54,  0 users,  load average: 1.00, 1.01, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 10:18:52AM +1000, Robert Lowery wrote:
> Hi,
> 
> I have recently acquired a PCI graphics card based on the SIS 6326 chipset.
> This chipset supports YUV->RGB conversion, Hardware motion compensation and
> iDCT in hardware.  Using Windows 98 and PowerDVD I am able to playback full
> screen DVD without any skipped frames on a Pentium 233MMX.  All for the
> cheap price of around $US20.
> 
> The full specs on this chipset are available at
> http://www.sis.com/ftp/Databook/6326/6326ds10.exe
> 
> The hardware acceleration of this card does not appear to be supported under
> linux, and I am unsure where the code should even go if I was to try and
> write it.
> 
> I have tried mailing to the livid-devel@linuxvideo.org, as I first thought
> this is where the code would belong, but have had no responses at all in 4
> days.  Is this Livid/OMS project still alive.
> 
> Alternatives (that I am aware of) are
> video4linux
> fbcon
> Xv
> 
> Where should this hardware support live, I suspect it does not belong in the
> kernel ;) and who should I be talking to.  I am willing to do a lot of the
> work to get this chipset supported, but since my device driver experience is
> somewhat limited, I would probably need a mentor ;)
> 
> Please cc any repies to me as I am not subscribed
> 
> Cheers
> 
> -Robert

This is definitely a job for XFree86, and Xv specificially.
Unfortunately, Xv only support the YUV->RGB conversion.  For the fancier
stuff, you'll need to use XvMC (motion compensation) which is still
somewhat experimental.

Redirect this question to the XFree86 devel lists and I think you'll get
better results.  Good luck on getting this supported!
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
