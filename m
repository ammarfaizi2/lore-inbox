Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSGUVez>; Sun, 21 Jul 2002 17:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSGUVez>; Sun, 21 Jul 2002 17:34:55 -0400
Received: from nameservices.net ([208.234.25.16]:27093 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S313898AbSGUVey>;
	Sun, 21 Jul 2002 17:34:54 -0400
Message-ID: <3D3B2A11.5DB3C08B@opersys.com>
Date: Sun, 21 Jul 2002 17:39:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Mark Spencer <markster@linux-support.net>
CC: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: Zaptel Pseudo TDM Bus
References: <Pine.LNX.4.33.0207211551350.25617-100000@hoochie.linux-support.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Spencer wrote:
> > That said, Adeos does offer what appears to be an very efficient model for
> > handling interrupts.  (Caveat: I haven't tried it myself yet, much less
> > measured it, just eyeballed the code)  You can load a module directly into
> > the interrupt pipeline and bypass all of Linux's interrupt machinery, even
> > bypass cli (it just sets a flag in Adeos).
> 
> If someone involved with, or familiar with, this project would care to
> contact me, I'd be happy to talk about RT enabling zaptel / asterisk.

Right here :)

Any driver that needs direct access to the interrupts can use Adeos' interrupt
pipeline. Your driver's low-level operations should be fairly easy to port to
Adeos.

Since Adeos' release, such porting of code has actually been successfully
done a couple of times already. Apart from Philippe's porting of the Xenomai
interface, here's an interesting tidbit that appeared on the Adeos mailing
list:
> We managed to get a proprietary (sorry nobody's perfect) RT nanokernel
> working with ADEOS. Thus we have two different OSes working at the same
> time on the same computer thanks to ADEOS. 

And yet another:
> I explored yesterday the Adeos nanokernel and was surprised by the
> possibilities and also the stability!
> 
> I tested for example multiple domains having different priorities and
> installing handlers on the same interrupt which works exactly is it is
> described.
> 
> I also tested snooping other interrupts (mouse/keyboard/ide0/ethernet)
> then the timer example provided in the package. (which works ofcourse
> also great)

Feel free to post any questions to Adeos' mailing list. It's been quite
active lately and I'm sure your application will interest others.

Adeos' web site is at:
http://www.freesoftware.fsf.org/adeos/

If you're looking for an introduction to Adeos' functionality have a look
at the original LKML announcement:
http://lwn.net/Articles/1743/

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
