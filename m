Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSILIPg>; Thu, 12 Sep 2002 04:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSILIPf>; Thu, 12 Sep 2002 04:15:35 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:31982
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S310190AbSILIPf>; Thu, 12 Sep 2002 04:15:35 -0400
Subject: Re: 2.4.18 serial drops characters with 16654
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Ed Vance <EdV@macrolink.com>,
       "'dchristian@mail.arc.nasa.gov'" <dchristian@mail.arc.nasa.gov>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D7FCDE0.200@domdv.de>
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE> 
	<3D7FCDE0.200@domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 09:20:55 +0100
Message-Id: <1031818855.2994.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 00:12, Andreas Steinmetz wrote:
> I did see something that looks quite similarl like dropped characters on 
> Redhat and 2.4.9 based UP systems (that's customers choice and couldn't 
> be changed) equipped with a NS-87336.
> I can't go into detail but my company did port an application from DOS 
> to Linux. The application communicates with an electronic cash device 

Other than the usual PIO mode IDE suspects I've had no problems going up
to 460800bps with a decent UART (ie one with a fifo). At 920Kbit/sec you
begin to overrun the flip buffers if you run with the usual 100Mhz timer
tick.

2.4 is a bit worse nowdays because of the ksoftirqd stuff but you could
easily disable that if you think it is triggering.

