Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWAYHwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWAYHwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWAYHwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:52:06 -0500
Received: from styx.suse.cz ([82.119.242.94]:8336 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750783AbWAYHwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:52:05 -0500
Date: Wed, 25 Jan 2006 08:51:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Martin Michlmayr <tbm@cyrius.com>, Al Viro <viro@ftp.linux.org.uk>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060125075159.GC23800@suse.cz>
References: <20060124181945.GA21955@deprecation.cyrius.com> <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com> <20060124231409.GA29982@deprecation.cyrius.com> <200601250004.06543.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601250004.06543.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:04:06AM -0500, Dmitry Torokhov wrote:
> On Tuesday 24 January 2006 18:14, Martin Michlmayr wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-24 18:08]:
> > > > More interesting question: is pis^H^H^Hsysfs interaction in there safe for
> > > > modular code?
> > > 
> > > The core should be safe, at least I was trying to make it this way, so
> > > if you see something wrong - shout. Locking is another question
> > > though...
> > 
> > So do you want an updated patch using _GPL to export the symbols or to
> > change CONFIG_INPUT to boolean?
> 
> I guess having input core as a module does not make much sense, so
> we should change CONFIG_INPUT to be boolean _and_ clean up the core
> code removing module unloading support.
 
Well, USB or SCSI cores are also modules, so I think there is some point
in having that functionality.

What were the required symbols?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
