Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVGOLgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVGOLgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVGOLgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:36:10 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:21386 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261167AbVGOLgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:36:07 -0400
Message-ID: <42D79FA2.90703@brturbo.com.br>
Date: Fri, 15 Jul 2005 08:36:02 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Johannes Stezenbach <js@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       Andrew Benton <b3nt@ukonline.co.uk>, linux-kernel@vger.kernel.org,
       "v4l >> Linux and Kernel Video" <video4linux-list@redhat.com>
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
References: <42D77E37.5010908@ukonline.co.uk>	<20050715110938.GB9976@linuxtv.org> <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de>
In-Reply-To: <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

	We'll include it at V4L.

Mauro.

Patrick Boettcher wrote:
> 
> Hmm, yes. When I changed the cx22702-driver to make it work with the
> cxusb-driver, I added another field to the struct cx22702_config to
> determine the output type.
> 
> I was well aware that this breaks support for the PCI cards, that's why I
> created a patch for the cx88-dvb.c and posted it the v4l-mailing list and
> ask for inclusion.
> 
> This was the Mail:
> http://www.linuxtv.org/pipermail/linux-dvb/2005-June/002383.html
> 
> This is the patch:
> Index: cx88-dvb.c
> ===================================================================
> RCS file: /cvs/video4linux/video4linux/cx88-dvb.c,v
> retrieving revision 1.42
> diff -u -3 -p -r1.42 cx88-dvb.c
> --- cx88-dvb.c    12 Jul 2005 15:44:55 -0000    1.42
> +++ cx88-dvb.c    15 Jul 2005 11:06:22 -0000
> @@ -166,12 +166,14 @@ static int mt352_pll_set(struct dvb_fron
> 
>  static struct mt352_config dvico_fusionhdtv = {
>      .demod_address = 0x0F,
> +    .output_mode   = CX22702_SERIAL_OUTPUT,
>      .demod_init    = dvico_fusionhdtv_demod_init,
>      .pll_set       = mt352_pll_set,
>  };
> 
>  static struct mt352_config dntv_live_dvbt_config = {
>      .demod_address = 0x0f,
> +    .output_mode   = CX22702_SERIAL_OUTPUT,
>      .demod_init    = dntv_live_dvbt_demod_init,
>      .pll_set       = mt352_pll_set,
>  };
> 
> Please include. Thanks
> 
> Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
> 
> best regards,
> Patrick.
> 
> -- 
>   Mail: patrick.boettcher@desy.de
>   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
> 
> -- 
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
> 
> 

