Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbUKDQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbUKDQkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUKDQkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:40:33 -0500
Received: from minimail.digi.com ([204.221.110.13]:3315 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP id S262290AbUKDQk1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:40:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: patch for sysfs in the cyclades driver
Date: Thu, 4 Nov 2004 10:40:26 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D824@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patch for sysfs in the cyclades driver
Thread-Index: AcTCcj/tuo3M8gk1SaCyGbYtck7h8AAFiFTw
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Germano" <germano.barreiro@cyclades.com>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marcelo Tosatti
> The problem was class_simple only contains the "dev" attribute. You
can't
> add other attributes to it.

Ah, that changes everything.

The entire reason Germano and I were chasing down this option,
was so we could export various "tty" statistic files out to below
each respective tty name in /sys/class/tty 

If its currently not possible to add more attributes to the simple
class,
then we are probably going down the wrong avenue here, at least for now.

Greg,
I know you are a very busy person...
Is making a "tty class" even in the cards for 2.6, or is it scheduled
for 2.7+ ?

Germano,
I still hate doing it, and I know it is against the "1 value per file in
sys" rule,
but for now I think exporting the values to the "card" directory with
each file 
containing the value as a list of ports, 1 per line, might be the best
option
to work with here, at least until the "tty class" gets developed.

Scott Kilau
Digi International
