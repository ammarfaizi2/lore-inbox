Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVAZXxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVAZXxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVAZXuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:50:51 -0500
Received: from canuck.infradead.org ([205.233.218.70]:5646 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261958AbVAZTln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:41:43 -0500
Subject: Re: don't let mmap allocate down to zero
From: Arjan van de Ven <arjanv@infradead.org>
To: linux-os@analogic.com
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 20:41:06 +0100
Message-Id: <1106768466.6307.157.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 11:38 -0500, linux-os wrote:
> On Wed, 26 Jan 2005, Rik van Riel wrote:
> 
> > With some programs the 2.6 kernel can end up allocating memory
> > at address zero, for a non-MAP_FIXED mmap call!  This causes
> > problems with some programs and is generally rude to do. This
> > simple patch fixes the problem in my tests.
> 
> Does this mean that we can't mmap the screen regen buffer at
> 0x000b8000 anymore?

you're confusing virtual and physical addresses



