Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTLHSUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTLHSUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:20:25 -0500
Received: from kuravelli.mail.saunalahti.fi ([195.197.172.113]:61129 "EHLO
	kuravelli.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261305AbTLHSUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:20:21 -0500
Date: Mon, 8 Dec 2003 20:24:24 +0200
From: Anssi Saari <as@sci.fi>
To: Ville Hallivuori <vph@iki.fi>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: CMPCI patch for 2.4.23 (fix multi channel audio, spdiff, game port)
Message-ID: <20031208182424.GA29415@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Ville Hallivuori <vph@iki.fi>, davej@redhat.com,
	linux-kernel@vger.kernel.org
References: <20031207201207.ED1F11B246@simpukka.saunalahti.fi> <20031207203802.GA6685@vph.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207203802.GA6685@vph.iki.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 10:38:02PM +0200, Ville Hallivuori wrote:

> #define	   SPDF_0	0x01
> #define	   SPDF_1	0x02
> to 
> #define	   SPDF_0	0x02
> #define	   SPDF_1	0x01
> 
> And change from function set_spdif_monitor line:
>   maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~SPDO2DAC, channel == 2 ? SPDO2DAC : 0);
> to:
>   maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~SPDO2DAC, channel == 1 ? SPDO2DAC : 0);
> 
> If this does not help. try looking for similar value pairs -- it seems
> that channel number assumptions are present in quite many places...

Yes, that fixed SPDIF out. However, I still don't have working
AC3 passthrough. I wish I knew more about the chip... At least
set_ac3_unlocked() seems to do the same thing for both versions.


