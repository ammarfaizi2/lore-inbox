Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264331AbUEXQKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbUEXQKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUEXQKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:10:33 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:46283 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264331AbUEXQKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:10:31 -0400
Date: Mon, 24 May 2004 18:10:30 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: cbradney@zip.com.au, Ian Kumlien <pomac@vapor.com>,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       christian.kroener@tu-harburg.de, Jamie Lokier <jamie@shareable.org>,
       Daniel Drake <dan@reactivated.net>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
In-Reply-To: <200405102137.11468.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0405180027000.29219@jurand.ds.pg.gda.pl>
References: <200405102137.11468.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Ross Dickson wrote:

> To my understanding IT WILL NEVER BE FIXED BY A BIOS REVISION and 
> after reading the 8259 datasheets I think it is a mistake within the
> existing code to have the timer_ack on there in the first place. 

 The timer_ack variation exploits the polling mode of the i8259A with the
AEOI enabled.  It's a valid configuration.  It's needed for a correct
operation of the timer interrupt handler and the NMI watchdog in certain
configurations.  What's there in the datasheets you that makes you think
the code is a mistake?  A reference would be appreciated.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
