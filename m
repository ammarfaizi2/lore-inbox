Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSE2Rm0>; Wed, 29 May 2002 13:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSE2Rm0>; Wed, 29 May 2002 13:42:26 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:22484 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314278AbSE2RmW>;
	Wed, 29 May 2002 13:42:22 -0400
Date: Wed, 29 May 2002 10:42:22 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Gibson <hermes@gibson.dropbear.id.au>, jt@hpl.hp.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
Message-ID: <20020529104221.I24843@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020522103834.B10921@bougret.hpl.hp.com> <E17Aams-0002Ue-00@the-village.bc.nu> <20020523012517.GM1001@zax> <1022697627.9255.272.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 07:40:27PM +0100, Alan Cox wrote:
> On Thu, 2002-05-23 at 02:25, David Gibson wrote:
> > The signal/noise bit is probably a red herring.  We have problems with
> > the reporting of this, but it's mostly cosmetic.  I seem to have
> > confusing and contradictory information about how to interpret the
> > values the firmware reports.
> 
> Ok the old driver gets the noise level right, the newer one got it
> wrong, the current one gets it wrong. The good news is the old one
> works, the new one didnt, the current 2.4.19pre one does...
> 
> Alan

	David,

	In the linux-wlan-ng, I did implement a different algorithm to
report signal/noise in /proc/net/wireless, based on various info on
the list. Mark Matthews did check with some people and told me it was
the right algorithm for the Intersil firmware.
	Note that I'm not sure we ever got it right.
	Also, in the past, we had the min/max wrapper that avoided
"strange" values, and I think that's what people are mostly
complaining about. So, maybe we should reintroduce the min/max.
	Regards,

	Jean
