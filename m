Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSLGTlL>; Sat, 7 Dec 2002 14:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSLGTlK>; Sat, 7 Dec 2002 14:41:10 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:53091
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264702AbSLGTlK>; Sat, 7 Dec 2002 14:41:10 -0500
Date: Sat, 7 Dec 2002 14:51:31 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Greg KH <greg@kroah.com>
cc: Adam Belay <ambx1@neo.rr.com>, "" <perex@suse.cz>,
       "" <linux-kernel@vger.kernel.org>, "" <pelaufer@adelphia.net>
Subject: Re: [PATCH] Linux PnP Support V0.93 - 2.5.50
In-Reply-To: <20021207192203.GB16559@kroah.com>
Message-ID: <Pine.LNX.4.50.0212071444540.3130-100000@montezuma.mastecende.com>
References: <20021201143221.GC333@neo.rr.com>
 <Pine.LNX.4.50.0212071322230.3130-100000@montezuma.mastecende.com>
 <20021207192203.GB16559@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2002, Greg KH wrote:

> > Could we get a void* in pnp_dev? I'm finding myself resorting to
> > driver internal arrays in order to track locations of device private structures.
>
> Use the struct device void pointer for stuff like this.  There's some
> helpful functions to get access to this easily (but don't seem to see
> them in pnp.h at first glance...)

Thanks these should do it.

static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)

	Zwane
-- 
function.linuxpower.ca
