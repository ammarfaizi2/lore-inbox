Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbTDFK5q (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTDFK5q (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:57:46 -0400
Received: from [66.70.28.20] ([66.70.28.20]:40709 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id S262926AbTDFK5p (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 06:57:45 -0400
Date: Thu, 3 Apr 2003 22:50:57 +0200
From: DervishD <raul@pleyades.net>
To: Greg KH <greg@kroah.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Mouse issue
Message-ID: <20030403205057.GA399@DervishD>
References: <20030402193731.GA1273@DervishD> <20030403005344.GA5361@kroah.com> <20030403101033.GC47@DervishD> <20030403170726.GA4849@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030403170726.GA4849@kroah.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Greg :)

    Thanks for your help about this issue :)

 Greg KH dixit:
> > > No, this interface (Major 180, minor 16) is long out of date.  You have
> > > to use the input core now.
> >     And that means activate INPUT_MOUSEDEV and load the module, ok,
> > but then, usbmouse does anything? Is it necessary for the USB mouse?
> The ONLY reason you would want to use the usbmouse driver is if you are
> building an embedded system.  Please read the configuration help files
> about this.

    Which one, Configure.help? I've read the entry for usbmouse and I
didn't found any info :?

> What you want is the hid driver.  Use that, and select INPUT_MOUSEDEV.

    Which advantages has this method. I mean, the mouse works with
gpm and usbmouse, and that is all I need. Maybe X problems?

> > but it is in use! Is this a bug? I'm afraid I must mark this module
> > as not autocleanable :((( and it will remain loaded even if I stop
> > using the mouse. Any advice?
> No, it's not a bug, it's the way the author wants it.  The module does
> not show up as being used as it would be a bit hard to unplug your
> mouse or keyboard and then try to unload the module :)

    Didn't think about that, obviously ;))) The fact that I never
hotunplug a USB device doesn't mean it cannot be done ;)) Anyway,
this renders the autoclean feature unusable for that module ¿true?.
So, you must unload it by hand or, better, built into core.

    Thanks for your kindness, Greg, and for clarifying all that for
me. I owe you a beer if you come to Spain sometime.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://www.pleyades.net/~raulnac
Quite embarrased of being spanish...
