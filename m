Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUHXPBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUHXPBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUHXPBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:01:13 -0400
Received: from aun.it.uu.se ([130.238.12.36]:19965 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267548AbUHXPBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:01:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16683.22576.781038.756277@alkaid.it.uu.se>
Date: Tue, 24 Aug 2004 17:01:04 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Shouldn't kconfig defaults match recommendations in help text?   
In-Reply-To: <Pine.LNX.4.61.0408232347380.3767@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0408232347380.3767@dragon.hygekrogen.localhost>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl writes:
 > [quote]
 > 
 > The processor's performance-monitoring counters are special-purpose
 > global registers. This option adds support for virtual per-process
 > performance-monitoring counters which only run when the process
 > to which they belong is executing. This improves the accuracy of
 > performance measurements by reducing "noise" from other processes.
 > 
 > Say Y.
 > 
 >   Virtual performance counters support (PERFCTR_VIRTUAL) [N/y/?] (NEW)
 > 
 > [/quote]
 > 
 > 
 > I just picked the above randomly, there are several other cases like it.
 > 
 > The comment clearly makes a recommendation that the user enables (in this 
 > case) the option, yet the default is the exact opposite. What is the point 
 > in that?
 > I don't see anything but confusion amongst users as the result of such 
 > inconsistency.

This particular mismatch occurs because the Kconfig entry
doesn't have a "default" line, so Kconfig defaults to "n".

It makes little sense to disable PERFCTR_VIRTUAL when
PERFCTR is enabled, so providing a "default y" for
PERFCTR_VIRTUAL is the right thing to do.
(It's an option because the design allows several
independent high-level services on top of the low-level
code. Currently there's only one high-level service in
2.6-mm, but with several it's reasonable to allow users
to enable only those they actually want.)

 > Would patches to change default configuration choices to match the 
 > recommendation given in the help text (if any) be acceptable? If not I'd 
 > be interrested in the reasons why not.
 > 
 > If such patches are acceptable/wanted I'll be happy to supply them.

Feel free to do so :-)

/Mikael
