Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272593AbTHEIVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272596AbTHEIVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:21:06 -0400
Received: from f25.mail.ru ([194.67.57.151]:55313 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S272593AbTHEIVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:21:03 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-hotplug-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Fw: [Cooker] usb audio detection problem
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 05 Aug 2003 12:21:02 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19jx42-000Eex-00.arvidjaar-mail-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> 
> > After a week of fighting with my new M-Audio USB Quattro device I have solved 
> > a problem with our hardwared detection.
> > I used the standard alsa configuration lines in /etc/modules.conf, i.e.
> > alias sound-slot-0 snd-usb-audio
> > above snd-usb-audio snd-pcm-oss
> > but when restarting alsa, the OSS driver was loading first (module name 
> > 'audio'), and then the alsa driver was unable to access the PCM stream.  By 
> > adding 'audio' to /etc/hotplug/blacklist, everything worked fine.
> > Is there some way to fix this permanently?
> > Is everyone else with usb-based audio currently forced to use OSS when 
> > Mandrake's default should be alsa?
> 
> both audio and snd-usb-audio modules have exactly the same matching
> criteria (in your case) and "audio" appears first in /lib/modules/`uname -r`/modules.usbmap so it wins.
> 
> I guess so far the ony "official" way is to blacklist it.

If having two modules with the same matching ids is expected,
what is normal way to prefer one of them? The problem currently
is system-wide usbmap is consulted first so there is actually
no way to override it.

This is under 2.4.21.

TIA

-andrey
