Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289956AbSAOPVI>; Tue, 15 Jan 2002 10:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289937AbSAOPU5>; Tue, 15 Jan 2002 10:20:57 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:38416 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S289908AbSAOPUm>; Tue, 15 Jan 2002 10:20:42 -0500
Date: Tue, 15 Jan 2002 16:20:00 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] cs46xx: sound distortion after hours of use
Message-ID: <20020115152000.GD13196@arthur.ubicom.tudelft.nl>
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 02:24:00PM -0200, Denis Vlasenko wrote:
> I have noticed that after hours of palying mp3s thru my onboard audio
> (I use cs46xx module) sound becomes distorted (high-pitch noise).
> 
> Restarting xmms does not help.
> 
> rmmod cs46xx; modprobe cs46xx fixes it.

Are you running a battery monitor or something similar? In that case it
can cause the CPU to go into SMM with interrupts disabled to talk to
the batteries and completely forget about servicing the audio IRQ
thereby fscking up the sound. I had the same problems on my laptop and
killing gnome_battery_applet fixed it.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
