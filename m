Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUFBN1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUFBN1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUFBN1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:27:54 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:4480 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S262850AbUFBN0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:26:50 -0400
Date: Wed, 2 Jun 2004 06:23:14 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Cc: Netdev <netdev@oss.sgi.com>, hostap@shmoo.com, prism54-devel@prism54.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Prism54 WPA Support - wpa_supplicant - Linux general wpa support
Message-ID: <20040602132313.GB7341@jm.kir.nu>
Mail-Followup-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Netdev <netdev@oss.sgi.com>, hostap@shmoo.com,
	prism54-devel@prism54.org, Jeff Garzik <jgarzik@pobox.com>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040602071449.GJ10723@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602071449.GJ10723@ruslug.rutgers.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 03:14:49AM -0400, Luis R. Rodriguez wrote:

> I'm glad wpa_supplicant exists :). Interacting with it *is* our missing
> link to getting full WPA support (great job Jouni). In wpa_supplicant 
> cvs I see a base code for driver_prism54.c (empty routines, just providing skeleton).
> Well I'll be diving in it now and see where I can get. If anyone else is
> interested in helping with WPA support for prism54, working with
> wpa_supplicant is the way to go.

I have a bit more code for this in my work directory somewhere (setting
the WPA IE and a new ioctl for this for the driver). I did not submit
these yet since the extended MLME mode was not working and the changes
were not yet really working properly. I can try to find these patches
somewhere.. Anyway, I would first like to see the extended MLME mode
working with any (even plaintext) AP and then somehow add the WPA IE to
the AssocReq. After that, it should be only TKIP/CCMP key configuration
and that's about it..

> I'm curious though -- wpa_supplicant is pretty much userspace. This was
> done with good intentions from what I read but before we get dirty 
> with wpa_supplicant I'm wondering if we should just integrate a lot of 
> wpa_supplicant into kernel space (specifically wireless tools).

Why? Which functionality would you like to move into kernel? Not that
I'm against moving some parts, but I would certainly like to hear good
reasons whenever moving something to kernel space if it can be done (or
in this case, has already been done) in user space..

> Regardless, as Jouni points out, there is still a framework for WPA that needs
> to be written for all linux wireless drivers, whether it's to assist
> wpa_supplicant framework or to integrate wpa_supplicant into kernel space.

The first thing I would like to see is an addition to  Linux wireless
extensions for WPA/WPA2 so that we can get rid of the private ioctls in
the drivers. Even though these can often be similar, it would be nice to
just write one driver interface code in wpa_supplicant and have it
working with all Linu drivers.. I hope to find some time to write a
proposal for this.

-- 
Jouni Malinen                                            PGP id EFC895FA
