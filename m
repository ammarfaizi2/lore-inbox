Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271186AbTHRB6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271187AbTHRB6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 21:58:41 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21983
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271186AbTHRB6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 21:58:39 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Compiling cardbus devices monolithic doesn't work?
Date: Sun, 17 Aug 2003 21:58:34 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308172158.34498.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm easing my way into the 2.6.0-test series, and everything I've done so far 
has been with monolithic kernels to minimize the number of fun new things 
I've been playing with, and I just can't get the monolithic orinoco_cs to 
find my new thinkpad's built-in wireless networking thingy.

I think it's because even though the sucker's built-in, the bus topology puts 
it behind its own cardbus bridge controller thingy (for no readily apparent 
reason).  Cardbus needs hotplug, hotplug wants to load modules.

Currently I'm booting into 2.4 when I need to use the internet.  I suppose 
it's time to actually fire up rusty's modutils, but before I do that I'm 
curious WHY the compiled-in orinoco_cs driver can't find the card.  
(Presumably because hotplug can't provide it with module arguments, or 
something like that?)  If they DO only work as modules, why are they allowed 
to be compiled monolithic?  (Did I miss a warning in the kconfig help text, 
or should I have read the relevant section of Documentation more closely?)

It's entirely possible there's some other reason my wireless card isn't 
working under 2.6, this is just a working hypothesis.  I'm happy to debug it 
if anybody has suggestions...

Rob

(P.S.  And while I'm at it, what's the relationship between orinoco_cs, 
orinoco, and hermes?  The /proc/modules dependency tree thing says they're 
using each other in a chain.  Probably true, just a bit odd, I thought.  
Couldn't figure out which driver I needed, compiled all three, and it loaded 
ALL of them.  Can't complain, the card works under 2.4.  This is just a 
random "huh?")
