Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272069AbTHNAWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272072AbTHNAWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:22:30 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:39334
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272069AbTHNAWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:22:23 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: George Anzinger <george@mvista.com>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Wed, 13 Aug 2003 20:24:36 -0400
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <3F32C752.4000403@wmich.edu> <3F355F12.4040609@mvista.com>
In-Reply-To: <3F355F12.4040609@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308132024.36967.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 16:52, George Anzinger wrote:
> Ed Sweetman wrote:
> > the problem is you want a process that works like it was run on a single
> > tasking OS on an operating system that is built from the ground up to be
> >  a multi-user multi-tasking OS

Considering the multi-tasking OS has 1000 times the CPU power, memory, and 
disk space as the single-tasking OS did when it debuted, yet still loses to 
it in some areas, isn't it at least worth looking at?

> > and you want both to work perfectly at peak performance

We're pondering various heuristics with which to to improve the situation and 
you say we're persuing perfection.  From heuristics.

Do you say these sort of things to the virtual memory people?  (Since you 
can't do it perfectly, why bother to swap at all?  The perfect being the 
enemy of the good, and all that.)

> > and you want it to know when you want which to work at
> > peak performance automatically.

I know for a fact that automatic determination of interactivity is possible.  
In OS/2 you could speed up a compile by  moving the mouse pointer over its 
window repeatedly to give it extra clock ticks.  (So far we've managed to 
avoid anything quite so disgusting in Linux, but there exist OSes where it 
was done.  Having the keyboard and mouse and display be local devices is 
actually the common case.  It took X about ten years to finally start 
optimizing for the common case on the output side with MIT shared memory 
extensions and such...)

The scheduler actually has a lot of information to work with.  Ingo's patches 
strive to give it more information, and and Con's patches make much better 
use of that information.  This is a good thing.

> Well said :)

Actually, I didn't really consider that list of straw man arguments to be 
worth commenting on the first time around.  (I thought he was being 
sarcastic...)

Rob
