Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVAGOtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVAGOtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVAGOs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:48:56 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:35508 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261443AbVAGOsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:48:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n6WEzbQ8+S5+BR4Bkgcm/+Q+NJOBzujPy82cKY57jMA0IC+9y7poZaRWCPtHCLfRU9vRc7RX30TRcMdwAS6ckRdPoq4bus60drt/cpkjx7cQZ2c84RE5EvQy/iOxO9dmUK0Zx/wGfZ6ZfoG+NLOekSKc8t4zNOKl2GzyR6RaXTI=
Message-ID: <d120d50005010706487bdff6e7@mail.gmail.com>
Date: Fri, 7 Jan 2005 09:48:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Cc: Takashi Iwai <tiwai@suse.de>, vojtech@suse.cz,
       Lion Vollnhals <webmaster@schiggl.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050107135418.GB1405@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104696556.2478.12.camel@pefyra>
	 <20050103084713.GB2099@elf.ucw.cz>
	 <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net>
	 <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net>
	 <loom.20050104T093741-631@post.gmane.org>
	 <20050104214315.GB1520@elf.ucw.cz> <41DC0E70.4000005@schiggl.de>
	 <20050106222927.GC25913@elf.ucw.cz> <s5hoeg1wduz.wl@alsa2.suse.de>
	 <20050107135418.GB1405@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005 14:54:18 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > > > I have a problem with net-devices, ne2000 in particular, in 2.6.9 and
> > > > 2.6.10, too. After a resume the ne2000-device doesn't work anymore. I
> > > > have to restart it using the initscripts.
> > > >
> > > > How do I add suspend/resume support (to ISA devices, like my ne2000)?
> > > > Can you point me to some information/tutorial?
> > >
> > > Look how i8042 suspend/resume support is done and do it in similar
> > > way...
> >
> > Yep it's fairly easy to implement in that way (I did for ALSA).
> >
> > But i8042 has also pm_register(), mentioning about APM.  Isn't it
> > redundant?
> 
> Yes, it looks redundant. Vojtech, could you check why this is still
> needed? It should not be.

It is removed in -bk.

-- 
Dmitry
