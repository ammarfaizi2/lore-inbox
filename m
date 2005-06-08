Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFHPHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFHPHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFHPG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:06:59 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:59311
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261301AbVFHPFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:05:55 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Denis Vlasenko'" <vda@ilport.com.ua>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Netdev list'" <netdev@oss.sgi.com>,
       "'kernel list'" <linux-kernel@vger.kernel.org>,
       "'James P. Ketrenos'" <ipw2100-admin@linux.intel.com>
Subject: RE: ipw2100: firmware problem
Date: Wed, 8 Jun 2005 09:05:27 -0600
Message-ID: <002901c56c3b$8216cdd0$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200506081744.20687.vda@ilport.com.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wednesday 08 June 2005 17:23, Pavel Machek wrote:
> > Hi!
> >
> > I'm fighting with firmware problem: if ipw2100 is compiled into
> > kernel, it is loaded while kernel boots and firmware loader
> is not yet
> > available. That leads to uninitialized (=> useless) adapter.

Pavel,

	I might be lost here but... How is the firmware loaded when using the
ipw2100-1.0.0/patches Kernel patch?

That patch normally works fine. It might not be the way you kernel
developers would like it, but maybe that could work the same way?


> >
> > What's the prefered way to solve this one? Only load firmware when
> > user does ifconfig eth1 up? [It is wifi, it looks like it would be
> > better to start firmware sooner so that it can associate to the
> > AP...].
>
> Do you want to associate to an AP when your kernel boots,
> _before_ any iwconfig had a chance to configure anything?
> That's strange.

Currently, when we install the driver, it associates to any open network on
boot. This is good, cause we don't want to be typing the commands all the
time just to associate. It works this way now and is pretty nice.

>
> My position is that wifi drivers must start up in an "OFF" mode.
> Do not send anything. Do not join APs or start IBSS.
> Thus, no need to load fw in early boot.
>
So, to scan a network, I would have to do ifconfig eth1 up ; iwlist eth1
scan?
When moving from modes with the firmwares, would I have to do ifconfig eth1
up ; iwconfig eth1 mode monitor? or would the firmware be loaded with
iwconfig? Does it have that function?

I'm not sure, but I guess that you guys should use the same method that the
source/patches uses?

.Alejandro

