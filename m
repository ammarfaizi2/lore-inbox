Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289636AbSAOUYu>; Tue, 15 Jan 2002 15:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289643AbSAOUYl>; Tue, 15 Jan 2002 15:24:41 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:26386 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S289636AbSAOUYa>; Tue, 15 Jan 2002 15:24:30 -0500
Date: Tue, 15 Jan 2002 21:24:03 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] cs46xx: sound distortion after hours of use
Message-ID: <20020115202402.GI13196@arthur.ubicom.tudelft.nl>
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua> <20020115152000.GD13196@arthur.ubicom.tudelft.nl> <3C4482A2.8040903@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C4482A2.8040903@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 11:27:30AM -0800, David C. Hansen wrote:
> Erik Mouw wrote:
> >Are you running a battery monitor or something similar? In that case it
> >can cause the CPU to go into SMM with interrupts disabled to talk to
> >the batteries and completely forget about servicing the audio IRQ
> >thereby fscking up the sound. I had the same problems on my laptop and
> >killing gnome_battery_applet fixed it.
> >
> I have the same problem, but very rarely.  I, too, use the 
> rmmod/modprobe technique to fix it.  Have either of you found a way to 
> excite the problem without waiting hours for it to happen?

'cat /proc/apm' is usually enough to trigger it on my laptop. Note that
my laptop needs the i810_audio+ac97_codec drivers.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
