Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWDYII6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWDYII6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWDYII5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:08:57 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:30972 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750897AbWDYII4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:08:56 -0400
From: Jani-Matti =?iso-8859-1?q?H=E4tinen?= <jani-matti.hatinen@iki.fi>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
Date: Tue, 25 Apr 2006 11:08:51 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com> <444CC4A3.3040309@drzeus.cx>
In-Reply-To: <444CC4A3.3040309@drzeus.cx>
X-Face: #cyYMAd}qudd3k4*S6mac8z1vRgtwXAC'7r{jv<~p5y80oOWqj0)0~/;,QeB(P>fhDJ"=?iso-8859-1?q?lF=0A=09=7D-ls=26?="0:\(7!/S)a_ew$J?hey[-+u`<VOlVBz48@)SW{u#N=v1P~`\Cd9^zw[>=?iso-8859-1?q?Z=607l=26XK=24=0A=09Deyz7Uf=5Dx?=@r"kOgh|l?F~QrgBEd<$x`a)[]1C"NqvG<T3Gk"@_,cH7Q;HTlZgb*F>VR(=?iso-8859-1?q?3j=0A=09=5ByC?=>>hR;jXQ!K/Q]*HjPibvm_33AQC_N2Z$VnZ<=?iso-8859-1?q?gy*4-QB2q=3A=5BoZ=2E-8YNsF+WK=27ya6u/!J=0A=09-4g=3B?=
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604251108.52515.jani-matti.hatinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman kirjoitti viestissään (lähetysaika maanantai, 24. huhtikuuta 
2006 15:29):
> Jani-Matti Hätinen wrote:
> >         Hello,
> >
> > For some reason I haven't been able to access sdhci-devel at drzeus.cx
> > for a week now, so sending this here.
>
> I see nothing in the logs from you so I suspect it's in your end. Other
> mail coming from pproxy.gmail.com (which is where you seem to be coming
> from) are coming through fine.

Looks like some kind of routing problem. Even pings don't seem to get through 
to mmc.drzeus.cx, or list.drzeus.cx. With http I get a timeout from 
mmc.drzeus.cx. This is from IP 80.221.18.58

jannu@lassi ~ $ ping mmc.drzeus.cx
PING gateway.drzeus.cx (85.8.13.51) 56(84) bytes of data.

--- gateway.drzeus.cx ping statistics ---
202 packets transmitted, 0 received, 100% packet loss, time 201694ms

jannu@lassi ~ $ ping list.drzeus.cx
PING list.drzeus.cx (193.12.253.7) 56(84) bytes of data.

--- list.drzeus.cx ping statistics ---
2226 packets transmitted, 0 received, 100% packet loss, time 2231122ms

> > I get a hard lock-up every single time, if I do modprobe sdhci after
> > waking up from suspend-to-ram. If I compile the module into the kernel
> > (or if I don't rmmod it before suspending), I get a lock-up either
> > when going to suspend (if there's a card in the reader) or during
> > resume (if the reader is empty). With a fresh boot-up the driver works
> > just fine. The problem occurs only after the machine has been
> > suspended at least once.
> >   I've tested this with 2.6.15-gentoo-r1 with the sdhci-0.11 patches
> > and vanilla 2.6.17-rc2. Sadly nothing gets as far as to the log when
> > the lock-up occurs.
>
> The kernel will not write anything to disk once a panic has occurred. To
> see what's going wrong need to be in text mode (framebuffer is not
> sufficient) when you do the modprobe.

Unfortunately even text mode is completely speechless about it. The modprobe 
goes through cleanly and I get the regular prompt (with a blinking cursor 
even), but the machine's completely locked up.

-- 
Jani-Matti Hätinen
