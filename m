Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUL0V33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUL0V33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUL0V32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:29:28 -0500
Received: from canuck.infradead.org ([205.233.218.70]:15121 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261987AbUL0V3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:29:25 -0500
Subject: Re: 2.4, 2.6, i686/athlon and LDT's
From: Arjan van de Ven <arjan@infradead.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Tymm Twillman <ttwillman@penguincomputing.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41D076D9.30404@didntduck.org>
References: <41D0668B.206@penguincomputing.com>
	 <1104178937.4187.16.camel@laptopd505.fenrus.org>
	 <41D076D9.30404@didntduck.org>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 22:29:17 +0100
Message-Id: <1104182957.4187.18.camel@laptopd505.fenrus.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 15:55 -0500, Brian Gerst wrote:
> Arjan van de Ven wrote:
> > On Mon, 2004-12-27 at 11:46 -0800, Tymm Twillman wrote:
> > 
> >>Hi all,
> > 
> > 
> >>It appears that use of the LDT is to speed up context switching between 
> >>threads, although I haven't even found especially good references WRT 
> >>that.  I have looked through the info in the IA Developers publications 
> >>and have whacked my head against Google quite a bit.  However, every bit 
> >>of clarity I've found there has been offset by new confuzled bits.
> > 
> > 
> > LDT's are *slow*. That's why glibc will try to avoid using them
> > nowadays, and with 2.6 it won't; as for 2.4.. it depends if you use a
> > vendor 2.4 it might be able to avoid using LDT's as well.
> 
> Using the LDT isn't inherently slower, since the cpu caches the segment 
> descriptor regardless of if it came from the GDT or LDT. 

it does however increase context switch costs significantly since the
LDT needs to be reloaded and reverified...


