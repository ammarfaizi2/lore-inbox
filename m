Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270528AbTGNFYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270529AbTGNFYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:24:17 -0400
Received: from wag1.wagora.com ([195.101.94.212]:40337 "EHLO wagora.com")
	by vger.kernel.org with ESMTP id S270528AbTGNFYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:24:15 -0400
Message-ID: <1058160485.3f123f65da7fa@www.france-techno.com>
Date: Mon, 14 Jul 2003 07:28:05 +0200
From: lich@tuxfamily.org
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Horst Von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: 2.5.75 doesn't boot at all on x86
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, Jul 13, 2003 at 03:50:31PM +0200, Anthony Lichnewsky wrote:
>  > After lilo, the kernel is uncompressed, then the screen goes black.
>  > the traditional init message is not even displayed
>  > ( INIT version 2.85 booting ).
>  > It accepts Ctrl+Alt+Suppr for reboot. but that's it.
>  >
>  > I checked that CONFIG_VT, CONFIG_VGA_CONSOLE are set in my .config.
>  > I suspect the initrd image is not loaded correctly, but I don't have any
>  > real clue. It was generated with mkinitrd version 3.4.43.
>  > Any Idea of what it might be ?
>
> Try CONFIG_VIDEO_SELECT=n. If that doesn't help, post your .config.
> (That config option really needs to tighten up what it does in
>  its EDID parser, see
http://www.cs.helsinki.fi/linux/linux-kernel/2003-20/052.html
>  which still isn't fixed...)
>
>               Dave
>
>
>
Thanks Dave.

I did that, and it left me with the kernel booting, but still no VT.
In fact, it appeared that rivafb that I use (says it detected my geForce
2, nevertheless ...) didn't do anything. I suppressed it and used vesafb
instead, and that was it.
I have now another strange problem, but I think I am not the only one to
experience it.

modprobe fails on /etc/modules.devfs and /etc/modules.conf at each
probeall line.
therefore, I dont have all modules up, particularly no mouse, no sound,
no pcmcia, no acpi, no ide-scsi cdrw/dvd ....

the message is
 modprobe: WARNING: /etc/modules.xxxx line xx: ignoring bad line
starting with 'probeall'

my modules.devfs only has probeall lines.
I use it also for my 2.4 kernels. What should I do ?? updated my
modultils to use modprobe-25. It looks like it doesn't support probeall
yet. Do I change all probeall for simple probes ?
The idea of  compiliing most of the modules into the kernel doesn't
appeal to me that much.

Is there any known workaround ?


Please cc me as I did not suscribe yet.

-anthony


---------------------------------------------------------
[FT] France Techno Web Mail - http://www.france-techno.com
