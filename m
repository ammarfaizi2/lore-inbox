Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312431AbSCURgq>; Thu, 21 Mar 2002 12:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312424AbSCURfA>; Thu, 21 Mar 2002 12:35:00 -0500
Received: from [209.250.53.17] ([209.250.53.17]:38148 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S312398AbSCUReQ>; Thu, 21 Mar 2002 12:34:16 -0500
Date: Thu, 21 Mar 2002 11:22:35 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020321172234.GA21274@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Danijel Schiavuzzi <dschiavu@public.srce.hr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <200203201506.QAA13795@jagor.srce.hr> <20020320172516.GA14024@hapablap.dyn.dhs.org> <200203211209.NAA11121@jagor.srce.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 10:57:36 up  9:54,  0 users,  load average: 1.07, 1.06, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, Mar 20, 2002 at 04:06:29PM +0100, Danijel Schiavuzzi wrote:
> > > Hm, I'm using the VIA VT8365 northbridge and I haven't found any '8365'
> > > entry in pci-pc.c, only this:
[...]

But it does show the "Disabling VIA Write Queue" during boot, yes?  If
not, then maybe it /does/ need to be added.  If it does, then try
commenting all but one of the device lines and see which one is causing
your system to run the fixup.  Then you can try commenting /it/ out, and
see if the screen corruption goes away.  Additionally, you could change
the "v &= 0x1f;" to "v &= 0x7f;" on line 1209 to only clear bit 7.

Let me know how that goes.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
