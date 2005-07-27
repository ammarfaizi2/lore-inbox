Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVG0MDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVG0MDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVG0MBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:01:34 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:31154 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262210AbVG0MBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:01:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christian Hesse <mail@earthworm.de>
Subject: Re: 2.6.12-ck4
Date: Wed, 27 Jul 2005 22:00:49 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ck list <ck@vds.kolivas.org>
References: <200507272111.27757.kernel@kolivas.org> <200507271328.45324.mail@earthworm.de>
In-Reply-To: <200507271328.45324.mail@earthworm.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507272200.50143.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005 21:28, Christian Hesse wrote:
> On Wednesday 27 July 2005 13:11, Con Kolivas wrote:
> > HZ-864.diff
> > +My take on the never ending config HZ debate. Apart from the number not
> > being pleasing on the eyes, a HZ value that isn't a multiple of 10 is
> > perfectly valid. Setting HZ to 864 gives us very similar low latency
> > performance to a 1000HZ kernel, decreases overhead ever so slightly, and
> > minimises clock drift substantially. The -server patch uses HZ=82 for
> > similar reasons, with the emphasis on throughput rather than low latency.
> > Madness? Probably, but then I can't see any valid argument against using
> > these values.
>
> Some time ago I tried with HZ=209, but the system then freezes after a few
> minutes... Any ideas what could be the reason? Are only even numbers
> allowed?

I don't really know. Perhaps there's some division or multiplication magic in 
a driver somewhere on your kernel that disagrees with it (although it 
shouldn't matter).

Cheers,
Con
