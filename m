Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUCYAL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUCYAJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:09:27 -0500
Received: from aelfric.plus.com ([80.229.143.166]:19420 "EHLO zaphod.hmmn.org")
	by vger.kernel.org with ESMTP id S262967AbUCYAGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:06:40 -0500
Date: Thu, 25 Mar 2004 00:06:38 +0000
From: Jonathan Sambrook <swsusp@hmmn.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040325000638.GD20026@hmmn.org>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <200403232352.58066.dtor_core@ameritech.net> <1080104698.3014.4.camel@calvin.wpcb.org.au> <opr5cry20s4evsfm@smtp.pacific.net.th> <1080107188.2205.10.camel@laptop-linux.wpcb.org.au> <opr5cu6ngl4evsfm@smtp.pacific.net.th> <20040324102632.GD512@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324102632.GD512@elf.ucw.cz>
Reply-By: Sat Mar 20 18:05:53 GMT 2004
X-OS: Linux 2.4.23 
X-Message-Flag: http://www.hmmn.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:26 on Wed 24/03/04, pavel@ucw.cz masquerading as 'Pavel Machek' wrote:
> Hi!
> 
> > >On Wed, 2004-03-24 at 18:22, Michael Frank wrote:
> > >>Error messages should be handled on a seperate VT eliminating the issue.
> > >
> > >While I definitely like the idea, I'm not sure that's feasible; as Pavel
> > >pointed out, Suspend doesn't generate all the error messages that might
> > >possibly appear. Maybe I'm just ignorant.. I'll take a look when I get
> > >the change.
> > 
> > printk is central and could do the switch when swsusp is active
> 
> You *could* do it, but it is bad idea. You don't want to patch
> printk.c, that driver printk could be done from interrupt (and you
> can't switch consoles at that point), you loose context, etc. What
> about doing the simple thing, maybe hack with CRs and be done with
> that?

What about getting rid of the progress bar and just print out at
swsusp2 log-level 9? We're used to scrolling boot messages after all.
(I do currently use bootsplash, but I have it underneath my boot
messages.)

Jonathan

> 
> If someone wants more eye candy, they have to patch their kernel with
> bootsplash.
> 								Pavel
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel

-- 


    .__
    |..|__   _____   _____   ___        ____  _    ____
    |;;|: \ /;:;:;\ /;:;:;\ /;:;\      /;;;;\/;\/\/;;;;\
    |   Y  \  Y Y  \  Y Y  \  Y  \    |  ___ \ |\_| ___ \
    |___|  /__|_|  /__|_|  /__|  /  o  \_____/ |  \___  /
         \/      \/      \/    \/            \/    _/  /
                                                   \__/
 
 hmmnsoft's FreeShade : window shading, for Windows, for free
 
                http://www.hmmn.org/FreeShade

