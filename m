Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130311AbQLNP2c>; Thu, 14 Dec 2000 10:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQLNP2W>; Thu, 14 Dec 2000 10:28:22 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:38560 "EHLO
	smtprelay2.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S130311AbQLNP2M>; Thu, 14 Dec 2000 10:28:12 -0500
Date: Thu, 14 Dec 2000 10:03:29 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: <200012141359.eBEDxFs46530@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.21.0012141001380.1522-100000@pii.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, Justin T. Gibbs wrote:

> >> I'll update my patch tomorrow to restore the definition of current.
> >> I do fear, however, that this will perpetuate the polution of the
> >> namespace should "current" ever get cleaned up.
> >
> >It can probably get cleaned up after 2.4 by making current() the actual 
> >inline. For 2.2 it won't change. Consider it a feature.
> >
> >It was done originally because the 2.0 code using #define based current
> >generated better code than using inline functions. 2.2 upwards use a different
> >(far nicer) method to find current.
> >
> >Note also that you cannot rely on 'get_current()'. The only way to find 
> >current is to use current. get_current() the inline is an x86ism.
> 
> I figured as much.  I will test for the #define, stash it in a #define
> unique within my namespace, and #define it back in hosts.c should my
> local define exist.

Justin,

While you're at it, can you have the new driver provide status information
under /proc/scsi/aic7xxx?  There is simply an empty pseudo-file called '0'
instead of the display provided by the current driver.

Steve


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
