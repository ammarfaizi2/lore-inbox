Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbTGDCIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbTGDB5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:57:49 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:50131 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265651AbTGDBz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:55:29 -0400
Subject: Re: 2.5.74-mm1 and Con Kolivas' CPU scheduler work
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: "ismail (cartman) donmez" <kde@myrealbox.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307040949.18588.kernel@kolivas.org>
References: <200307031936.34458.kde@myrealbox.com>
	 <200307040949.18588.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057284551.1725.8.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jul 2003 22:09:12 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4, required 10, AWL,
	EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_01_02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 19:49, Con Kolivas wrote:
> On Fri, 4 Jul 2003 02:36, ismail (cartman) donmez wrote:
> > Hi,
> >
> > With Con Kolivas' cpu patch I got many slow downs. When I try to run
> > CodeWeaver's CrossOver office box gets unresponsive at least for a one
> > minute. While starting KDE ( when splash screen is running ) mouse gets too
> > sluggish.
> 
> While your wm starting if your mouse is sluggish it is probably not a big 
> problem, and it is part of something I'm already working on. The codeweavers 
> problem is impressive though; I don't have codeweavers and have not seen 
> anything like it. To get a full picture it would be helpful if you could run 
> top as root say reniced to -13 just so it doesn't miss anything, and then 
> start codeweavers, watch top and tell me what is spinning away hogging the 
> cpu.

My guess is that he's seeing the same issue that I reported a few weeks
ago with Crossover plugin.  That report generated a fairly long thread
and a lot of patches and testing, but little actual progress.  Basically
wine seems to have multiple threads and a client/server architecture and
seems constantly spin on a pipe passing info back and forth to each
other.  It seems one thread gets all the attention and starves the
others although the others are critical for the main process to actually
make progress.

I've been wanting to do some testing with your patches so I'll give them
a spin tonight and see how this acts.

Later,
Tom


