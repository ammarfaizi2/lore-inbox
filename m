Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVGKQZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVGKQZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVGKQZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:25:31 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:31247 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262100AbVGKQXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:23:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kFKTqgbxHuGUvDylfru/6JOBG/eqMlER70cQVXhRn35hIvN7bsLI8hd6rEXpC/bBzxt8vCPjEhEbt47c+XsgQItffv4ZU3tcwVgaYqs/d4fO0bgfZq1PrIclYQUcU1pCO/7wKlHUJrqmlH+wQZFZMAZe4VhqXNSmC1c/ZHbYCSE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Hal Rosenstock <halr@voltaire.com>
Subject: Re: [PATCH 3/27] Add MAD helper functions
Date: Mon, 11 Jul 2005 20:29:26 +0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
References: <1121089079.4389.4511.camel@hal.voltaire.com> <200507111839.41807.adobriyan@gmail.com> <1121094791.4389.4591.camel@hal.voltaire.com>
In-Reply-To: <1121094791.4389.4591.camel@hal.voltaire.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507112029.26890.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2005 19:30, Hal Rosenstock wrote:
> On Mon, 2005-07-11 at 10:39, Alexey Dobriyan wrote:
> > On Monday 11 July 2005 17:48, Hal Rosenstock wrote:
> > > Add new helper routines for allocating MADs for sending and formatting
> > > a send WR.
> > 
> > > -- linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c
> > > +++ linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c
> > 				   ^^^^^^^^^^^
> > Ick. You'd better have linux-2.6.13-rc2-mm1-[0123...].
> 
> Shall I resubmit with linux-2.6.13-rc2-mm1-[0123...] ?

I'd wait for comments and then resubmit clean series which can be applied
with patch -p1.

> > > +struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
> > > +					    u32 remote_qpn, u16 pkey_index,
> > > +					    struct ib_ah *ah,
> > > +					    int hdr_len, int data_len,
> > > +					    int gfp_mask)
> > 
> > unsigned int __nocast gfp_mask, please. 430 or so infiniband sparse warnings
> > is not a reason to add more.
> 
> I'll fix this in a subsequent patch. Is that OK ?

If Andrew will fix patches locally, OK.
