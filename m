Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276087AbRI1Ov2>; Fri, 28 Sep 2001 10:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276088AbRI1OvT>; Fri, 28 Sep 2001 10:51:19 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:48654 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S276087AbRI1OvC>;
	Fri, 28 Sep 2001 10:51:02 -0400
Date: Fri, 28 Sep 2001 16:51:23 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
Message-ID: <20010928165122.L21524@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3BB48A34.E392B7BC@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BB48A34.E392B7BC@mail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 10:33:24AM -0400, Thomas Hood wrote:

> Hi Stelian.
> 
> Try this patch.  It is a modification of the latest
> pnpbios driver patch to 2.4.9-ac16 which includes
> hacks to work on a Vaio laptop.  If this works then
> I'll clean it up a bit and submit to Alan.

It works, kind of.

The only remaining problem is that the DMI scan routines are
called _after_ the PnP BIOS scan, so the is_sony_vaio_laptop
variable will be always evaluated to 0 in your patch (causing
the same hang again).

After manually changing is_sony_vaio_laptop to 1 the
patched kernel boots ok, entries in /proc/bus/pnp are present
(not sure how to test if their contents are corect though).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
