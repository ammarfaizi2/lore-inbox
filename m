Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVGHScD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVGHScD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 14:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVGHScC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 14:32:02 -0400
Received: from web88003.mail.re2.yahoo.com ([206.190.37.190]:30888 "HELO
	web88003.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262378AbVGHScB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 14:32:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wenlznmfc2X6t3bBXbjK6bAGeQcoxwApGO8/Sqjamb68KopDfS8+5a44Zs4Et5vXvH5azAoGhVLJjmhkwms3eB+s7iwlm9fEPZ8f1iq7JZFJ1G9ExokSSCICOCkcXNw95ef2c+9aZpOQJofLYqLbPkrZL7E1uBye6HLLg5RzuX8=  ;
Message-ID: <20050708183200.54019.qmail@web88003.mail.re2.yahoo.com>
Date: Fri, 8 Jul 2005 14:32:00 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
To: Jens Axboe <axboe@suse.de>, Jon Escombe <lists@dresco.co.uk>
Cc: Shawn Starr <spstarr@sh0n.net>, hdaps-devel@lists.sourceforge.net,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       LKML List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050708063156.GP24401@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should be noted im using linux-2.6.git. 

--- Jens Axboe <axboe@suse.de> wrote:

> On Fri, Jul 08 2005, Jon Escombe wrote:
> > Jens Axboe wrote:
> > 
> > >On Thu, Jul 07 2005, Shawn Starr wrote:
> > > 
> > >
> > >>Model: HTS548080M9AT00 (Hitachi)
> > >>Laptop: T42.
> > >>
> > >>segfault:/home/spstarr# ./a /dev/hda
> > >>head parked
> > >>
> > >>Seems to park, heard it click :)
> > >>   
> > >>
> > >
> > >Note on that - if the util says it parked, you
> can be very sure that it
> > >actually did as the drive actually returns that
> status outside of just
> > >completing the command.
> > > 
> > >
> > It's worth noting that you'll need the libata
> passthrough patch to make 
> > this work on a T43..
> > 
> > However, with this patch I'm getting the "head not
> parked 4c" message, 
> > but I can hear the click from the drive.. It takes
> around 350-400ms for 
> > the command to execute, but when repeated, it
> drops to around 5ms for a 
> > short while (with no audible clicking), before
> reverting to original 
> > behaviour after a few seconds.
> > 
> > The clicking and the variation in execution time
> lead me to think it is 
> > parking, but not being reported correctly?
> 
> Sounds like a pass through bug, it should pass the
> register output back
> out again for a non-data command.
> 
> Checking code... Yeah it does not. Since the 'we
> parked successfully' is
> stored in the lbal register, we need the full
> register set copied back
> into the buffer. That goes for all three HDIO_*
> commands, there's still
> some work to be done for the libata passthrough to
> be compliant with the
> ide one.
> 
> -- 
> Jens Axboe
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With
> Dual!' webinar happening
> July 14 at 8am PDT/11am EDT. We invite you to
> explore the latest in dual
> core and dual graphics technology at this free one
> hour event hosted by HP,
> AMD, and NVIDIA.  To register visit
> http://www.hp.com/go/dualwebinar
> _______________________________________________
> Hdaps-devel mailing list
> Hdaps-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/hdaps-devel
> 

