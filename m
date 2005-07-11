Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVGKRKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVGKRKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVGKRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:08:44 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:30665 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262238AbVGKRGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:06:21 -0400
Subject: Re: [PATCH 3/27] Add MAD helper functions
From: Hal Rosenstock <halr@voltaire.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <200507112029.26890.adobriyan@gmail.com>
References: <1121089079.4389.4511.camel@hal.voltaire.com>
	 <200507111839.41807.adobriyan@gmail.com>
	 <1121094791.4389.4591.camel@hal.voltaire.com>
	 <200507112029.26890.adobriyan@gmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1121100534.4389.4609.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 12:58:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 12:29, Alexey Dobriyan wrote:
> On Monday 11 July 2005 19:30, Hal Rosenstock wrote:
> > On Mon, 2005-07-11 at 10:39, Alexey Dobriyan wrote:
> > > On Monday 11 July 2005 17:48, Hal Rosenstock wrote:
> > > > Add new helper routines for allocating MADs for sending and formatting
> > > > a send WR.
> > > 
> > > > -- linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c
> > > > +++ linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c
> > > 				   ^^^^^^^^^^^
> > > Ick. You'd better have linux-2.6.13-rc2-mm1-[0123...].
> > 
> > Shall I resubmit with linux-2.6.13-rc2-mm1-[0123...] ?
> 
> I'd wait for comments and then resubmit clean series which can be applied
> with patch -p1.
> 
> > > > +struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
> > > > +					    u32 remote_qpn, u16 pkey_index,
> > > > +					    struct ib_ah *ah,
> > > > +					    int hdr_len, int data_len,
> > > > +					    int gfp_mask)
> > > 
> > > unsigned int __nocast gfp_mask, please. 430 or so infiniband sparse warnings
> > > is not a reason to add more.
> > 
> > I'll fix this in a subsequent patch. Is that OK ?
> 
> If Andrew will fix patches locally, OK.

I will work this into the resubmitted patches.

-- Hal

