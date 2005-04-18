Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVDRLPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVDRLPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVDRLPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:15:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15826 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262034AbVDRLP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:15:29 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Arjan van de Ven <arjan@infradead.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1113822345.365.14.camel@localhost.localdomain>
References: <200504172339.j3HNdIDF011543@harpo.it.uu.se>
	 <1113822345.365.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 13:14:58 +0200
Message-Id: <1113822898.6274.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 13:05 +0200, Alexander Nyberg wrote:
> [Proper patch now that goes all the way, sorry for spamming]
> 
> Patch below uses RETIRED_UOPS for a more constant rate of NMI sending.
> This makes x64 deliver NMI interrupts every fourth second at a constant
> rate when going through the local apic. Makes both cpus on my box to get
> NMIs at constant rate that it previously did not, there could be long
> delays when a CPU was idle.


isn't this dangerous in the light of the mobile cpus that either scale
back or stop entirely in idle or lower load situations ?


