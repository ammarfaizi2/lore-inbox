Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWGRJi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWGRJi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGRJi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:38:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:16806 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932112AbWGRJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:38:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XfTDm9LcCsOtBKyr99Z487b8vEyUwlU48LHQHphpaRa8uOj74sxeYiuRUdq9OPB41wejLXxCFk0u0PHmUb046lgvglYg21ggCyIMVpTMf4hvR+F0bU0fizVTbyKmvjyn12eaLt3SdAeg9MooZT8OuMW1nxBasaV9v+b1Ecmlw58=
Message-ID: <f96157c40607180238s1bfe0ca2te1d4d72dbe8626fd@mail.gmail.com>
Date: Tue, 18 Jul 2006 11:38:25 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060714150418.120680@gmx.net>
	 <Pine.LNX.4.64.0607171242440.6761@scrub.home>
	 <20060717133809.150390@gmx.net>
	 <Pine.LNX.4.64.0607171605500.6761@scrub.home>
	 <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
	 <Pine.LNX.4.64.0607171718140.6762@scrub.home>
	 <f96157c40607170858o567abe24r5d9bdd4895a906c9@mail.gmail.com>
	 <f96157c40607170902l47849e42qc4f1c64087a236d8@mail.gmail.com>
	 <Pine.LNX.4.64.0607171902310.6762@scrub.home>
	 <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, gmu 2k6 <gmu2006@gmail.com> wrote:
> On 7/17/06, Roman Zippel <zippel@linux-m68k.org> wrote:
> > Hi,
> >
> > On Mon, 17 Jul 2006, gmu 2k6 wrote:
> >
> > > either I'm too dumb or there is an undocumented way to enable SysRq on
> > > bootup or the machine is really hanging hard. I'm not able use
> > > Alt+Print as nothing happens besides console showing the typed in
> > > characters ^[t.
> >
> > It might be a keyboard problem, try releasing Print, but keeping Alt
> > pressed and then try another key.
>
> maybe the problem is HP's Integrated Lights Out Java Applet. I will
> try tomorrow morning in the server room.

yep that Java Applet was the problem. it worked when I was physically
connected by keyboard. I got the following by pressing Alt+SysRq+p but
I'm not sure it helps as being in cpu_idle looks normal to me:
Pid: 0, comm: swapper
EIP: 0060 [<c0101a57>] CPU: 0
EIP: isat mwait_idle+0x2a/0x34
EAX: 00000000 EBX: c0414008 ECX: 00000000 EDX: 00000000
ESI: c0414000 EDI: c33984e4 EPP: 00004864 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f818cc CR3: 375e73c0 CR4: 000006f0
[<c0101a175>] cpu_idle+0x63/0x79
[<c041a6cf>] start_kernel+0x262/0x393
[<c041a1c3>] unknown_bootoption+0x0/0x25a

Alt+SysRq+s seems to sync and write the logs to kern.log/messages but
the logs vanish after reboot. Therefore for the time being I had to
write it down by hand but I'm sure there's an elegant way like saving
the logfiles before booting up again via a second system or livecd.
Maybe there's a better way than that?
