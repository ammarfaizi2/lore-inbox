Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWC0SBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWC0SBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 13:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWC0SBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 13:01:47 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:53705 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751100AbWC0SBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 13:01:47 -0500
Date: Mon, 27 Mar 2006 13:01:45 -0500
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>, linux@horizon.com,
       kalin@thinrope.net, linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
Message-ID: <20060327180145.GD16773@csclub.uwaterloo.ca>
References: <20060326162100.9204.qmail@science.horizon.com> <4426C320.9010002@yandex.ru> <20060327161845.GA16775@csclub.uwaterloo.ca> <Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 12:44:50PM -0500, linux-os (Dick Johnson) wrote:
> Experimental data show that it is not possible to 'destroy' the
> chip by interrupting a write as previously reported by others.
> In fact, one of the destroyed devices was recovered by writing
> all the sectors in the device as in:
>  	 `dd if=/dev/zero of=/dev/hdb bs=1M count=122`.

I have a destroyed card here.  And I tried doing that.  A rep from
sandisk told me, that yes that model/generation of sandisk could
encounter that situation where the device was simply impossible to
access because of corruption during a write.  He also said the card
would have to be sent back to the factory to have the table reset.
Newer generations were going to fix that so it didn't happen again.

> Note that there __is__ a problem that may become a "gotcha" if
> you intend to RAW copy devices, one to another, for production.
> The reported size (number of sectors) is different between
> devices of the same type and manufacturer! Apparently, the size
> gets set when the device is tested.

Yeah, I load cards by partitioning, mkfs'ing, and extracting data.
Different manufacturers almost never have the same excact size.

Len Sorensen
