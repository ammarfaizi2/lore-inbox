Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTFKQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTFKQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:26:55 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:51165 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id S263187AbTFKQ0y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:26:54 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BDA78@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: =?iso-8859-15?Q?=27Mika_Penttil=E4=27?= <mika.penttila@kolumbus.fi>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2][2.5]Unisys ES7000 platform subarch
Date: Wed, 11 Jun 2003 11:40:05 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika,
I always get this cluster terminology questions :) I have to remove these
words once and for all (I thought I did... I will though.)

Clustering on ES7000 follows Intel guidelines, but not quite fall into
certain cluster model category. According to Intel book, cluster can be flat
(on the same bus) or hierarchical (physically separate bus segments). Flat
cluster uses serial bus messaging (like on xAPIC systems) and can support 15
agents. On both APIC models that ES7000 utilizes, it can support 32
processors (with xAPICs, 64 hypothreaded P4's, if only OS could support
that). It has special arrangement for the APIC buses and corresponding
numbering for APICs, which reflects its topological nature, so the
conventional APIC cluster numbering schema won't work. Due to those
differences, our clusters are not that "flat", and we call it "physical",
and "logical" really means "hierarchical". I think, our cluster model names
came from some previous distributions that implemented both models, I swear
I didn't invent it myself. They just worked for our case.

--Natalie

-----Original Message-----
From: Mika Penttilä [mailto:mika.penttila@kolumbus.fi]
Sent: Wednesday, June 11, 2003 9:57 AM
To: Protasevich, Natalie
Cc: Linux Kernel
Subject: Re: [PATCH 2/2][2.5]Unisys ES7000 platform subarch


Just out of curiosity, what are "Physical Cluster" and "Logical 
Cluster"?  This terminology doesn't appear in Intel documentation. 
AFAIK, IPIs are currently always sent using logical destination mode, 
and in your patch ioapic entries have logical mode in cluster case. So 
where does physical cluster  come into play?

--Mika

