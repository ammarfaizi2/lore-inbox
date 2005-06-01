Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVFAXoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVFAXoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVFAXnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:43:18 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:33192 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261453AbVFAXkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:40:33 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: External USB2 HDD affects speed hda
Date: Wed, 1 Jun 2005 16:40:14 -0700
User-Agent: KMail/1.7.1
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Mark Lord <lkml@rtr.ca>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <429BA001.2030405@keyaccess.nl> <200506011337.29656.david-b@pacbell.net> <429E359D.8090701@keyaccess.nl>
In-Reply-To: <429E359D.8090701@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011640.15147.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 3:24 pm, Rene Herman wrote:

> I see. Well, sort of at least. "Even if the HDD were using periodic 
> transfers, which it isn't, it would be DMAing 32-bits 8x per msec while 
> idle, which certainly isn't going to cost 8MB/s bus bandwidth". Right?

Well, "certainly" is hard to say without the kind of PCI-bus level
logic analyser thing.  Flakey PCI implementations could chew up lots
of bandwidth.  It _should_ not take 8 MB/s bandwidth.  But if it's
chewing up bandwidth, and you're already near the limit in terms
of throughput on that hardware (doesn't need to be at the theoretical
ceiling!) then regular small demands could conceivably chew up more
bandwidth than you'd like.

- Dave
