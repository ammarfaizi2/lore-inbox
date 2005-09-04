Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVIDW4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVIDW4n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVIDW4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:56:43 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:21055 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932100AbVIDW4m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:56:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UvjkQ6fOnPm7kFPKkgipA4xZrGMOBZ3onQRTE6Jmj5ErQlMjPTiTxyarPr/4iadkMeJoVTGxSzbiaYCKMdVIMpKD3f7GIYUKKMoQAlPiVtExN3ihelyZShSnIvjlDvOpPT2jmXQGknTgFubgyftAKRCHB3JfKiUB9LH31C2JdUY=
Message-ID: <9a8748490509041556771499f5@mail.gmail.com>
Date: Mon, 5 Sep 2005 00:56:40 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Matt LaPlante <laplam@rpi.edu>
Subject: Re: Potential IPSec DoS/Kernel Panic with 2.6.13
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200509042242.j84MgYWg019419@ms-smtp-01-eri0.southeast.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a87484905090411492cc3f823@mail.gmail.com>
	 <200509042242.j84MgYWg019419@ms-smtp-01-eri0.southeast.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Matt LaPlante <laplam@rpi.edu> wrote:
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Jesper Juhl
> > Sent: Sunday, September 04, 2005 2:49 PM
> > To: Matt LaPlante
> > Cc: Herbert Xu; linux-kernel@vger.kernel.org
> > Subject: Re: Potential IPSec DoS/Kernel Panic with 2.6.13
> >
> > >
> > serial console over a cross-over cable to a second box.
> > netconsole will let you put the console on a different box over the
> > network.
> > console on line printer will let you have a permanent record of the
> > console output on paper.
> >
> > See
> >  Documentation/serial-console.txt
> >  Documentation/networking/netconsole.txt
> >  the help entry for "config LP_CONSOLE" (in drivers/char/Kconfig)
> >
> 
> Well I've tried for several hours now to get netconsole working, but it just
> won't give me output.  I've tried using both built in as well as module, and
> I've tried two different clients using both netcat and syslogd on different
> ports.  The most output I ever get is when loading the module I manage to
> receive one message saying "netconsole: network logging started".  I've
> verified all the netconsole settings are correct in the kernel logs when it
> loads.  I'm not one to give up easily, but this one's got me stumped.
> 
> I know the option to use a printer is out...I might be able to manage a
> serial connection, but I'll have to rebuild my kernel to support it.  I'll
> look into that later...
> 

Hmm, just a guess; since your bug kills networking I'd suspect that
perhaps netconsole is not the best option. Serial console or printer
(if you have one obviously) would probably be better options.
If you can't get netconsole to work even for stuff prior to triggering
the oops, then that's a bit odd. Perhaps if you posted a description
of exactely what it is you are doing someone could point out the
error...   Personally I haven't used netconsole for quite a while, so
my memory of how to set it up is a bit rusty, but I don't recall it
being /that/ tricky.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
