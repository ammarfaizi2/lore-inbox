Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbUDNKOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbUDNKOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:14:42 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:30639 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264028AbUDNKOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:14:41 -0400
Date: Wed, 14 Apr 2004 12:14:39 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jon Grimm <jgrimm2@us.ibm.com>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       phil.el@wanadoo.fr
Subject: Re: io_apic & timer_ack fix
In-Reply-To: <407CC3DB.3070300@us.ibm.com>
Message-ID: <Pine.LNX.4.55.0404141210550.17639@jurand.ds.pg.gda.pl>
References: <200404100337.21730.ross@datscreative.com.au>
 <Pine.LNX.4.55.0404131412101.15949@jurand.ds.pg.gda.pl> <407CC3DB.3070300@us.ibm.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Jon Grimm wrote:

> I 've been running the patch on a 2.4.21 code base.  I note that 
> /proc/interrupts shows NMI interrupts coming in fast and furious, where 
> without it there were none.   I'm not sure what to think of  this.

 This is the NMI watchdog -- an aid to debug lock-ups.  You can control it
with the "nmi_watchdog=" kernel option -- see documentation.  I suppose 
without the timer_ack change the watchdog wouldn't work for some reason 
-- perhaps due to problems with your 8259A core or with the SMM.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
