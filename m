Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUBWJLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUBWJLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:11:25 -0500
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:45778 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261886AbUBWJLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:11:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: 2.6.3-ck1
Date: Mon, 23 Feb 2004 20:11:06 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200402182336.31420.kernel@kolivas.org> <1077378620.9311.1.camel@gimli.at.home>
In-Reply-To: <1077378620.9311.1.camel@gimli.at.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402232011.06573.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sun, 22 Feb 2004 02:50, Bernd Petrovitsch wrote:
> On Wed, 2004-02-18 at 13:36, Con Kolivas wrote:
> > http://kernel.kolivas.org
> >
> > Description:
> > am6
> > Autoregulates the virtual memory swappiness.
>
> This actually has a problem if swapping is disabled via the .config
> file. The patch uses 'swapper_space.nrpages' which does not exist (in
> the no-swap-space situation). Instead 'total_swapcache_pages' apparently
> should be used.

Thanks.

I'll modify it at some stage to just ifdef that out if swapping is disabled 
via the .config instead since that code does nothing for the no-swap config. 
Kernel dev time is very limited, sorry.

Cheers,
Con
