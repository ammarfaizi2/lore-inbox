Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbSI3QJt>; Mon, 30 Sep 2002 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262163AbSI3QJt>; Mon, 30 Sep 2002 12:09:49 -0400
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:23559
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262126AbSI3QJs>; Mon, 30 Sep 2002 12:09:48 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A79D1@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Russell King'" <rmk@arm.linux.org.uk>
Cc: Marek Michalkiewicz <marekm@amelek.gda.pl>, linux-kernel@vger.kernel.org,
       Tim Waugh <twaugh@redhat.com>
Subject: RE: [patch] fix parport_serial / serial link order (for 2.4.20-pr
	e8)
Date: Mon, 30 Sep 2002 09:15:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, September 30, 2002 at 2:49 AM, Russell King wrote:
> On Mon, Sep 30, 2002 at 10:40:12AM +0100, Tim Waugh wrote:
> > On Thu, Sep 26, 2002 at 10:05:16PM +0200, Marek Michalkiewicz wrote:
> > > below is a patch that moves parport_serial.c from drivers/parport/
> > > to drivers/char/ - this fixes the wrong link order when the 
> > > drivers are compiled into the kernel.
> > 
> > What was wrong with the original, much smaller patch that you sent 
> > me previously (below)?
> > 
> > I'm happy to accept whichever patch is the better.
> 
> Other than it's a gross hack rather than a fix.  However, for 2.4, I
> think this is probably the best solution without creating a risk of
> other init ordering problems.  Ed, any comments?
> 
Hi Russell,

I agree. For 2.4, Stability before elegance. Minimum change is a good thing.
The patch looks straight-forward enough, simply plop the file into a
directory for which it was never intended. It does localize the effect of
the change nicely. 

I have a question. Similar changes have been suggested several times and
always seem to bring out a small hail of rather negative comments. (like
"gross hack ..." :) 

Are there any hidden issues with the patch? That is, beyond the decrease in
maintainability? I didn't see anything relevant to this technique in the
lkml archive. I'm a little wary of anything that gets an "oh no, not this
again" reaction. Hmmm... I think I hear the distant sound of arrows being
sharpened. 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              serial24 (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
