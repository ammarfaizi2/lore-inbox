Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUKVWpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUKVWpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbUKVWmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:42:50 -0500
Received: from mail1.infiniconsys.com ([65.219.193.230]:44434 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S261171AbUKVWlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:41:09 -0500
From: "Fab Tillier" <ftillier@infiniconsys.com>
To: "'Greg KH'" <greg@kroah.com>, "Roland Dreier" <roland@topspin.com>
Cc: <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
Subject: RE: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA(Subnet Administration) query support
Date: Mon, 22 Nov 2004 14:40:45 -0800
Message-ID: <000401c4d0e4$4edb43d0$655aa8c0@infiniconsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-reply-to: <20041122222507.GB15634@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-OriginalArrivalTime: 22 Nov 2004 22:41:03.0175 (UTC) FILETIME=[58A81D70:01C4D0E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, November 22, 2004 2:25 PM
> 
> > +struct ib_sa_hdr {
> > +	u64			sm_key;
> > +	u16			attr_offset;
> > +	u16			reserved;
> > +	ib_sa_comp_mask		comp_mask;
> > +} __attribute__ ((packed));
> 
> Why is this packed?
> 
> > +struct ib_sa_mad {
> > +	struct ib_mad_hdr	mad_hdr;
> > +	struct ib_rmpp_hdr	rmpp_hdr;
> > +	struct ib_sa_hdr	sa_hdr;
> > +	u8			data[200];
> > +} __attribute__ ((packed));
> 
> Same here?

These describe on-the-wire IB structures, and their definition matches the
IB spec (Version 1.1, Volume 1)

struct ib_mad_hdr matches "Standard MAD Header", Figure 144
struct ib_rmpp_hdr matches "RMPP MAD Header", Figure 168
struct ib_sa_hdr and struct ib_sa_mad match "SA Header", Figure 193

Hope that answers your question - let us know if it doesn't.

Cheers,

- Fab

