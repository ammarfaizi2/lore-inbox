Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUDTMlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUDTMlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUDTMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:41:08 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:35036 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262547AbUDTMk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:40:56 -0400
Date: Tue, 20 Apr 2004 14:40:55 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Niclas Gustafsson <niclas.gustafsson@codesense.com>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       Patricia Gaughen <gone@us.ibm.com>
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
In-Reply-To: <1082452873.20179.34.camel@gmg.codesense.com>
Message-ID: <Pine.LNX.4.55.0404201431360.28193@jurand.ds.pg.gda.pl>
References: <1081416100.6425.45.camel@gmg.codesense.com> 
 <1081465114.4705.4.camel@cog.beaverton.ibm.com>  <1081932857.17234.37.camel@gmg.codesense.com>
  <Pine.LNX.4.55.0404151633100.17365@jurand.ds.pg.gda.pl> 
 <1082048278.17234.144.camel@gmg.codesense.com> <1082452873.20179.34.camel@gmg.codesense.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Niclas Gustafsson wrote:

> I've now been running the system since last week, about 6 days now with
> sometimes quite high load, both in regard to CPU usage and network
> traffic.
> And it seems to be running just fine with the patch from Maciej.

 I'm glad to read this.

> I've got a couple of questions, 
> 
> When was this bug introduced? Was it 2.6.1 ( or rather somewhere in
> 2.5)? Or was it already present in 2.4?

 Well, the bug has been introduced by IBM in their firmware (SMM code).  
;-)  The patch only works it around.  Functionally the changed code is the
same for your configuration.

 If you are asking about the problematic code, then it's there since
2.3.x, so it's in 2.4, too.  It's a part of the NMI watchdog support,
though it's used for ordinary timer interrupts for certain systems as
well.

> When will this patch be merged into the 2.6-tree?  I don't have to
> stress the impact of this problem on IBM servers as they are rendered
> quite useless.

 Apparently there are problems with the workaround on certain AMD
Athlon-based systems.  I suppose they need to be resolved somehow first.

> Which other IBM models are affected? Can I run 2.6.5 on my 345:s or
> 335:s?  Do they use the same buggy SMM firmware?

 Ask IBM.  The reason is an incorrect handling of PIC (8259A) state
saving/restoration.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
