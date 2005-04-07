Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVDGS40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVDGS40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVDGS4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:56:25 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:6332 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262553AbVDGSy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:54:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=iqxdDcKLvmGNv2H/Ri+6gqqebkb4ZmUe85hLzVKmQINAQB9rM4E+eUboin9EU3FinQeWC33Pwz+AOxuqVPZiPjMWJMkENGh/GDmHShHfRKifpzrJRoF5dHYscNHhU4DBYscq5/QrcfGdPhdoov4i3HVDiJc0js0WVOwtLYqw8wE=
Message-ID: <29495f1d05040711544695ce89@mail.gmail.com>
Date: Thu, 7 Apr 2005 11:54:26 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Moritz Muehlenhoff <jmm@inutil.org>
Subject: Re: Linux 2.6.12-rc2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050407175026.GA5872@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7535_4489349.1112900066204"
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
	 <1112827342.9567.189.camel@gaston>
	 <20050407175026.GA5872@informatik.uni-bremen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7535_4489349.1112900066204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Apr 7, 2005 10:50 AM, Moritz Muehlenhoff <jmm@inutil.org> wrote:
> Benjamin Herrenschmidt wrote:
> > > 1. When resuming from S3 suspend and having switched off the backlight
> > > with radeontool the backlight isn't switched back on any more.
> >
> > I'm not sure what's up here, it's a nasty issue with backlight. Can
> > radeontool bring it back ?
> 
> Before suspending I power down the backlight with "radeontool light off"
> and with 2.6.11 the display is properly restored. With 2.6.12rc2 the
> backlight remains switched off and if I switch it on with radeontool it
> becomes lighter, but there's still no text from the fbcon, just the blank
> screen.

FWIW, I have the same problem on a T41p with 2.6.11 and 2.6.12-rc2,
except that neither returns from suspend-to-ram with video restored on
the LCD. I believe I was able to get video restored on an external CRT
in either 2.6.12-rc2 or 2.6.12-rc2-mm1, but the LCD still didn't
restore (can verify later today, if you'd like). I had dumped out the
radeontool regs values before & after the sleep, in case they help.
They are attached.

I posted these problems in the "Call for help S3" thread, but no one responded.

Thanks,
Nish

------=_Part_7535_4489349.1112900066204
Content-Type: application/octet-stream; name=radeontool_pre
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="radeontool_pre"

RADEON_DAC_CNTL=ff002102
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=07770142
RADEON_DISP_OUTPUT_CNTL=10000008
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=0d008048
RADEON_CRTC_GEN_CNTL=03000200
RADEON_CRTC2_GEN_CNTL=00800000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=003cffa1

------=_Part_7535_4489349.1112900066204
Content-Type: application/octet-stream; name=radeontool_post
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="radeontool_post"

RADEON_DAC_CNTL=ff002102
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=00770103
RADEON_DISP_OUTPUT_CNTL=1000000a
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=00000048
RADEON_CRTC_GEN_CNTL=03000200
RADEON_CRTC2_GEN_CNTL=02000000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=080c0089

------=_Part_7535_4489349.1112900066204--
