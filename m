Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWAZWRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWAZWRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWAZWRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:17:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15110 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964920AbWAZWRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:17:37 -0500
Date: Thu, 26 Jan 2006 23:17:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Martin Michlmayr <tbm@cyrius.com>, Al Viro <viro@ftp.linux.org.uk>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060126221735.GA3668@stusta.de>
References: <20060124181945.GA21955@deprecation.cyrius.com> <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com> <20060124231409.GA29982@deprecation.cyrius.com> <200601250004.06543.dtor_core@ameritech.net> <20060125075159.GC23800@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125075159.GC23800@suse.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 08:51:59AM +0100, Vojtech Pavlik wrote:
> On Wed, Jan 25, 2006 at 12:04:06AM -0500, Dmitry Torokhov wrote:
> > On Tuesday 24 January 2006 18:14, Martin Michlmayr wrote:
> > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-24 18:08]:
> > > > > More interesting question: is pis^H^H^Hsysfs interaction in there safe for
> > > > > modular code?
> > > > 
> > > > The core should be safe, at least I was trying to make it this way, so
> > > > if you see something wrong - shout. Locking is another question
> > > > though...
> > > 
> > > So do you want an updated patch using _GPL to export the symbols or to
> > > change CONFIG_INPUT to boolean?
> > 
> > I guess having input core as a module does not make much sense, so
> > we should change CONFIG_INPUT to be boolean _and_ clean up the core
> > code removing module unloading support.
>  
> Well, USB or SCSI cores are also modules, so I think there is some point
> in having that functionality.
>...

The difference is that USB and SCSI are not that essential, and 
therefore not always enabled if CONFIG_EMBEDDED=n. It's therefore e.g. 
not uncommon that distributions offer modular USB and SCSI cores.

Are there really people building kernels for that much space limited 
environments that they set CONFIG_EMBEDDED=y, and at the same time want 
CONFIG_INPUT=m?

I'd have expected people using CONFIG_EMBEDDED=y to usually also set 
CONFIG_MODULES=n for getting a smaller kernel.

> Vojtech Pavlik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

