Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272972AbTGaNnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272998AbTGaNnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:43:00 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272972AbTGaNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:41:20 -0400
Date: Thu, 31 Jul 2003 14:51:00 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307311351.h6VDp0w3000146@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, mru@users.sourceforge.net
Subject: Re: fun or real: proc interface for module handling?
Cc: nico-kernel@schottelius.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was just joking around here, but what do you think about this idea:
> >
> > A proc interface for module handling:
> >    /proc/mods/
> >    /proc/mods/<module-name>/<link-to-the-modules-use-us>
> >
> > So we could try to load a module with
> >    mkdir /proc/mods/ipv6
> > and remove it and every module which uses us with
> >    rm -r /proc/mods/ipv6
>
> So far, so good.
>
> > Modul options could be passed my
> >    echo "psmouse_noext=3D1" > /proc/mods/psmouse/options
> > which would also make it possible to change module options while runn=
> ing..
>
> How would options be passed when loading?  Some modules require that
> to load properly.  Also, there are lots of options that can't be
> changed after loading.  To enable this, I believe the whole option
> handling would need to be modified substantially.  Instead of just
> storing the values in static variables, there would have to be some
> means of telling the module that its options changed.  Then there's
> the task of hacking all modules to support this...

Or you could just cause the module to be unloaded and reloaded
whenever options changed.

Not that I like this idea anyway, but then I don't use modules :-).

John.
