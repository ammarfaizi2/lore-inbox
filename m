Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTJ3BAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 20:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTJ3BAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 20:00:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15510
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262104AbTJ3BAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 20:00:44 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Suspend to disk panicked in -test9.
Date: Wed, 29 Oct 2003 18:57:40 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310291857.40722.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, while I was writing down the panic on a piece of paper, the 
screen blanking code kicked in while I was still copying down the register 
values.  I remember that the call trace mentioned some variant of a 
write_stuff_to_disk call, but that's not that useful...

When is the last time that the screen blanking code actually accomplished 
something useful?  These days it seems to exist for the purpose of destroying 
panic call traces and annoying people.  (I seem to remember that pressing a 
key used to make it come back, but now we're forced to use the input core 
that no longer seems to be the case...)

I also seem to remember a patch floating by on the list that would make 
console screen blanking go away.  I really think console screen blanking NOT 
being enabled should be the default these days.  Or at the very least, when 
there's a panic it should get shut off.  I'll add looking into that to my 
to-do list, but will probably get to it somewhere around 2009...

Rob
