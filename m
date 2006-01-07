Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbWAGSms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbWAGSms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWAGSmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:42:47 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:41760 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030535AbWAGSmr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:42:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nGY3fhTf+NJuQ7ZPwRgjUCEmDzUw552qLyWOdegezFm+sggvVGWRLf0A0qRN1R1X/dXcqCqPVsxyyEowcUAifKMlM9KOC3GYJkEcOClQ3VeAym1sY1dWLDoFAzPOX1CotQgKhY/r0U6uCAxuYSk4NUJLwI5TV8cVZs4MZqGWvE4=
Message-ID: <37219a840601071042m157d1bb7k4a18105e038e9fad@mail.gmail.com>
Date: Sat, 7 Jan 2006 13:42:46 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [linux-dvb-maintainer] [RFC: 2.6 patch] drivers/media/dvb/: possible cleanups
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060107181258.GM3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107181258.GM3774@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/06, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global functions:
>   - b2c2/flexcop-dma.c: flexcop_dma_control_packet_irq()
>   - b2c2/flexcop-dma.c: flexcop_dma_config_packet_count()
>
> Please review which of these changes do make sense and which conflict
> with pending patches.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  drivers/media/dvb/b2c2/flexcop-common.h      |    2 -
>  drivers/media/dvb/b2c2/flexcop-dma.c         |    4 ++
>  drivers/media/dvb/b2c2/flexcop-misc.c        |    6 ++--
>  drivers/media/dvb/b2c2/flexcop-reg.h         |    4 --
>  drivers/media/dvb/bt8xx/dst.c                |   19 +++++--------
>  drivers/media/dvb/bt8xx/dst_common.h         |    5 ---
>  drivers/media/dvb/dvb-usb/cxusb.c            |    2 -
>  drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 +++--
>  drivers/media/dvb/dvb-usb/dvb-usb.h          |    1
>  drivers/media/dvb/dvb-usb/vp702x.c           |    6 ++--
>  drivers/media/dvb/dvb-usb/vp702x.h           |    2 -
>  drivers/media/dvb/ttpci/av7110.h             |    2 -
>  drivers/media/dvb/ttpci/av7110_ir.c          |   26 +++++++++----------
>  13 files changed, 38 insertions(+), 49 deletions(-)


Adrian,

At first glance, I already see many collisions with pending
patchsets...  Mauro is getting ready to push a whole bunch of patches
onto the v4l-dvb git tree.

Could you please wait until after those get merged?

Also, I'm not sure about some of the changes here... Hopefully some of
the other DVB guys will have some comments.  I think it's better to
postphone reviewing this until after we merge our new v4l / dvb stuff.

Regards,
Michael Krufky
