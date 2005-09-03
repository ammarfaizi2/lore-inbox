Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVICTSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVICTSq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVICTSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 15:18:46 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:53926 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751197AbVICTSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 15:18:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=bX7guAqTyI71HoWy7Bt8xMXM2zskqPi+CsQ8PhhSe9yy2Yk3KFuSj92HmR3AoE/n2j20SXpv0BiIIKDlVXVsxtmsy3j60GmPZVkKz1QGfTEfEUrDrN8BV/CrMp0H5AbmSxzPSQOldUYX4i1QZlOw6bIxL84OIQoufUkFp5cZMQA=
Message-ID: <4319F706.3000506@gmail.com>
Date: Sat, 03 Sep 2005 21:18:30 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: Request for review
References: <4IJQu-3kG-19@gated-at.bofh.it>
In-Reply-To: <4IJQu-3kG-19@gated-at.bofh.it>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni ha scritto:
> Dears,
> 
> I wrote a first release of a SAR helper module for Linux 2.6.x.
> 
> It is conceptually similar to the Duncan Sands' usb_atm module, but it is not constrained to usb devices and is a bit different from it in its implementation details.
> 
> It seems to me that scores some points in this:
> 
> - supplies a coherent interface which allows the device driver to bypass
> 	almost any interaction with the atm layer;
> 
> - supports ATM header&hec check, correction and generation, which is
> 	most useful for dumb atm devices (ie: most ADSL modems);
> 
> - supports automatic and fast routing of received cells to destinating
> 	vcc;
> 
> - actually supports AALraw, AAL0 and AAL5;
> 
> - aal decoding/encoding routines are designed as atmsar plug-ins, so
> 	that further types may easily be supported;
> 
> - implements speed- and memory-concerned techniques for per-vcc
> 	decoding;
> 
> - allows using dma-streaming techniques in sending cells to device;
> 
> - supports tx buffer adjusting against device needs;
> 
> - avoids vcc open/close paradigm handling in device driver;
> 
> - yields a uniform view to SAR status in /proc.
> 
> 
> I'm contacting you firstly because I would like to hear your point of view about the whole idea (am I reinventing the wheel?), then because I would like to have my code reviewed, and lastly because I have some question about the matter.
> 
> I prepared the SAR module as a patch against the Linux 2.6.12.3 kernel tree. It is attached to this message as a unified diff.
> 
> Also, in order to allow you to evaluate it, I prepared a driver adopting the SAR module's API for the Globespan Pulsar ADSL PCI card. This driver is made after the one from Guy Ellis (see http://adsl4linux.no-ip.org/pulsar.html for further reference). My version is a two-part driver: a GPL one ( http://www.tomassoni.biz/download/pulsar/pulsaradsl-1.0.1-source.tar.bz2 ) and a proprietary library ( http://www.tomassoni.biz/download/pulsar/libpulsar_fw.a.bz2 ) which shall be decompressed and put in the pulsaradsl-1.0.1 directory in order to build the driver. The libpulsar_fw.a is the one for GCC 3. If you need a version of this library for another GCC flavor, please see the above reported Ellis' pulsar site.
> 
> Note also that I'm allowing you to download a copy of the libpulsar_fw.a library only for the purpose of evaluating the SAR module: it is not meant to be used otherway.
> 
> My intention, if the maintainer of the ATM stack under Linux (Chas Williams) and the author of the usb_atm module (Duncan Sands) agree, is to merge the atmsar module into the linux tree, thereby replacing the atm+sar code in the Verrept-Sands' atm_usb module, which will then contain only the usb handling code and eventually will relay on the atmsar module for its atm+sar ops. I'm also looking for help by Sands to do this. Also, it could be interesting to have the Ellis' driver use this module, as the Pulsar PCI ADSL card is actually the only ADSL PCI modem of which I'm aware.
> 
> Questions are spread in comments in the atmsar sources. I can of course ask them by e-mail, but let the Q&A phase follow your feedbacks about the need for this brand-new wheel...
> 
> Regards,
> 
> -----------------------------------
> Giampaolo Tomassoni - IT Consultant
> Piazza VIII Aprile 1948, 4
> I-53044 Chiusi (SI) - Italy
> Ph: +39-0578-21100


i see a sort of non-sense in your (argh!!) binary (but just for 
evaluation) library.


