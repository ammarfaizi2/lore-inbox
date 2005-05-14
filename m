Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVENSBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVENSBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVENSBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 14:01:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56709 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262817AbVENSBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 14:01:43 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116093396.9141.11.camel@mindpipe>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
	 <1116088229.8880.7.camel@mindpipe>
	 <1116089068.6007.13.camel@laptopd505.fenrus.org>
	 <1116093396.9141.11.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 14 May 2005 20:01:33 +0200
Message-Id: <1116093694.6007.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Sat, 2005-05-14 at 13:56 -0400, Lee Revell wrote:
> On Sat, 2005-05-14 at 18:44 +0200, Arjan van de Ven wrote:
> > then JACK is terminally broken if it doesn't have a fallback for non-
> > rdtsc cpus. 
> 
> It does have a fallback, but the selection is done at compile time.  It
> uses rdtsc for all x86 CPUs except pre-i586 SMP systems.
> 
> Maybe we should check at runtime,

it's probably a sign that JACK isn't used on SMP systems much, at least
not on the bigger systems (like IBM's x440's) where the tsc *will*
differ wildly between cpus...


