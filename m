Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUDMNqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 09:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbUDMNqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 09:46:13 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:26852 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263375AbUDMNqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 09:46:12 -0400
Date: Tue, 13 Apr 2004 15:46:10 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Len Brown <len.brown@intel.com>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2
In-Reply-To: <200404131703.09572.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0404131526090.15949@jurand.ds.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au>
 <1081832914.2253.623.camel@dhcppc4> <200404131703.09572.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Ross Dickson wrote:

> Maciej forwarded me some an override patch he developed for another
> architecture where one could spec MP info as kernel args and that worked but
> we still had no nmi_debug=1 with the timer_ack=1 situation, which he then
> fixed in 2.6.3-mm3 but it got pulled for 2.6.4
> 
> Maciej, is that override code good to go on latest kernels? I am a novice to 
> acpi parsing etc.

 I suppose it should be fine.

> Unfortunately spurious interrupts contribute to disconnect rate - and there
> are lots of those in XT-PIC mode. I hacked the proc/interrupts code to view
> them on irq7 and it was really bad if I used local apic without io-apic.

 Spurious interrupts are normally recorded in the "ERR" entry in
/proc/interrupts, so you shouldn't have to record them separately.  And
there should be none counted, except perhaps a few arriving upon 
initialization of the local APIC.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
