Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318925AbSHEWo4>; Mon, 5 Aug 2002 18:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318926AbSHEWoz>; Mon, 5 Aug 2002 18:44:55 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:33038 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318925AbSHEWoy>; Mon, 5 Aug 2002 18:44:54 -0400
Date: Tue, 6 Aug 2002 00:48:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <200208052212.g75MCrN17655@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208060034260.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Aug 2002, Richard Gooch wrote:

> > > Yes. RTFS.
> >
> > I'm trying - without getting headache.
>
> Take a valium.

Staying away from devfs sources is cheaper.

> > In the "devfs=only" case, where is the module count incremented, when a
> > block device is opened?
>
> The module count is incremented when the device is opened,
> irrespective of whether it's a character or block device, or even a
> "regular" file.

Would you please answer my question and tell me where that exactly
happens in that case?

> > > No. I leverage fops_get(), a common function.
> >
> > Which is also insufficiently protected.
>
> Incorrect.

What protects the module from unloading from getting the ops pointer until
try_inc_mod_count()?

bye, Roman

