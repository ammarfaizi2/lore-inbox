Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVHOPJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVHOPJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 11:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVHOPJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 11:09:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7893 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964797AbVHOPJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 11:09:19 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux@horizon.com, lkml.hyoshiok@gmail.com
In-Reply-To: <p73u0hr1bwc.fsf@verdi.suse.de>
References: <20050815121555.29159.qmail@science.horizon.com.suse.lists.linux.kernel>
	 <1124108702.3228.33.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
	 <p73u0hr1bwc.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 17:09:12 +0200
Message-Id: <1124118553.3228.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 17:02 +0200, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > On Mon, 2005-08-15 at 08:15 -0400, linux@horizon.com wrote:
> > > Actually, is there any place *other* than write() to the page cache that
> > > warrants a non-temporal store?  Network sockets with scatter/gather and
> > > hardware checksum, maybe?
> > 
> > afaik those use zero copy already, eg straight pagecache copy.
> 
> Only if you use sendfile(). And the normal write path uses csum_copy_* 

but do those use s/g ? and hw csum?


