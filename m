Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbTAaDFR>; Thu, 30 Jan 2003 22:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTAaDFR>; Thu, 30 Jan 2003 22:05:17 -0500
Received: from 12-240-9-4.client.attbi.com ([12.240.9.4]:20353 "EHLO
	pinkie.homelinux.net") by vger.kernel.org with ESMTP
	id <S267694AbTAaDFQ>; Thu, 30 Jan 2003 22:05:16 -0500
Message-ID: <3E39E9FC.5070307@lbl.gov>
Date: Thu, 30 Jan 2003 19:14:04 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin K. Petersen" <mkp@mkp.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>	<3E384D41.9080605@lbl.gov>	<1043926998.28133.21.camel@irongate.swansea.linux.org.uk>	<3E395C30.6040903@lbl.gov>	<1043950661.31674.12.camel@irongate.swansea.linux.org.uk>	<3E396032.2000503@lbl.gov>	<1043951291.31674.17.camel@irongate.swansea.linux.org.uk>	<3E39669F.20302@lbl.gov>	<1043955332.31674.27.camel@irongate.swansea.linux.org.uk>	<3E39730D.3090009@lbl.gov> <yq1vg06qlhk.fsf@austin.mkp.net>
In-Reply-To: <yq1vg06qlhk.fsf@austin.mkp.net>
Content-Type: multipart/mixed;
 boundary="------------000701040109060105050801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000701040109060105050801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin K. Petersen wrote:
>>>>>>"Thomas" == Thomas Davis <tadavis@lbl.gov> writes:
> 
> 
> Thomas,
> 
> Alan is right.  I have yet to see an FM801 with the AC97 codec
> on the chip.
> 
> Thomas> How do I get the name in there other than "Unknown"?
> 
> Thomas> It's a single chip card.
> 
> What kind of card is it?  Are you sure there isn't a tiny codec chip
> hiding somewhere?
> 

The card has 3 chips on it

1 - TEA2025 audio stereo amp
2 - DT9011 - ??
3 - DT0389

So, it is ok to make it "Diamond Technology DT0389"?

See attached patch.

--------------000701040109060105050801
Content-Type: text/plain;
 name="forte_ac97_codec"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="forte_ac97_codec"

--- linux-2.4.21-pre2/drivers/sound/ac97_codec.c	Tue Dec 24 15:37:53 2002
+++ linux-2.4.20-ac1/drivers/sound/ac97_codec.c	Fri Dec  6 00:07:04 2002
@@ -133,6 +133,7 @@
 	{0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
 	{0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
 	{0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+	{0x44543031, "Diamond Technology DT0398",       &null_ops},
 	{0x45838308, "ESS Allegro ES1988",	&null_ops},
 	{0x49434511, "ICE1232",			&null_ops}, /* I hope --jk */
 	{0x4e534331, "National Semiconductor LM4549", &null_ops},

--------------000701040109060105050801--

