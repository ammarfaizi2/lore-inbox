Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTDVOvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTDVOvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:51:39 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:61616 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S263180AbTDVOvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:51:38 -0400
Date: Tue, 22 Apr 2003 17:02:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
In-Reply-To: <200304211752_MC3-1-3560-DA1F@compuserve.com>
Message-ID: <Pine.GSO.3.96.1030422165952.20928B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Chuck Ebbert wrote:

>  But doesn't IRQ 0x80, even though it is software-initiated, contend
> with 'real' device interrupts at priority 8, which would mean there are
> three possible sources (80, 81 and 89?)  That's what I was assuming...

 Problems are with local APIC hardware (with queueing arriving IRQ
messages); "int 0x80" doesn't go through the APIC. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

