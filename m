Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTFYXXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbTFYXXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:23:34 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:48294 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264612AbTFYXXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:23:32 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andy Pfiffer <andyp@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: patch O1int for 2.5.73 - interactivity work
Date: Thu, 26 Jun 2003 09:39:38 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
References: <200306260209.45020.kernel@kolivas.org> <1056577981.603.3.camel@teapot.felipe-alfaro.com> <1056582622.1200.5.camel@andyp.pdx.osdl.net>
In-Reply-To: <1056582622.1200.5.camel@andyp.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306260939.38723.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003 09:10, Andy Pfiffer wrote:
> On Wed, 2003-06-25 at 14:53, Felipe Alfaro Solana wrote:
> > On Wed, 2003-06-25 at 18:09, Con Kolivas wrote:
> > > Hi all
> > >
> > > I've used the corner cases described that cause a lot of the
> > > interactivity problems to develop this patch.
> >
> > This patch is indeed much better than the ones posted before. In fact,
> > it's really, really hard for me to make XMMS skip audio. It feels much
> > better in general, but there are still some rough edges when the system
> > is under load. For example, the mouse cursor on an X session doesn't
> > move smoothly, and feels a little jumpy. It can be somewhat fixed by
> > renicing the X server to -20.
>
> I'm running with this patch on my dual-proc desktop right now.
>
> I agree: with a make -j20 going, the mouse became non-responsive
> for about 1 second at a time.  Renicing the X server to -20 greatly
> improved the response of my desktop with this patch under load.
>
> I could switch virtual desktops (blackbox), move the mouse to focus on
> an aterm and type a command (and get a response back), and not wait
> too long for evolution to repaint or open a piece of email.
>
> I could tell that something was grinding away on my system, but it was
> still tolerable.

Thanks for testing this.  The maximum interactive-non interactive difference 
to tasks niced to 0 will be 10, so renice X to -11 should be the most you 
need... -10 is what a lot of distributions already do by default. 

Are there any other corner cases you've found with this patch? I have ideas 
about the "starting xmms under extreme load" issue but I need to know if it's 
a real life scenario, and whether building an algorithm around one 
application in one setting is worthwhile.

Also to those actually looking at the code, would you like me to comment it in 
detail? I kept it short on purpose, but adding comments would be simple 
enough.

Con

