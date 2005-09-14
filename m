Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVINORU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVINORU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVINORU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:17:20 -0400
Received: from hera.kernel.org ([209.128.68.125]:63885 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965179AbVINORU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:17:20 -0400
Date: Wed, 14 Sep 2005 11:11:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Pantelis Antoniou <panto@intracom.gr>,
       Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
Message-ID: <20050914141131.GA6830@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet> <20050901085319.GB6285@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901085319.GB6285@isilmar.linta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 10:53:19AM +0200, Dominik Brodowski wrote:

> > +typedef struct  {
> > +	u_int regbit;
> > +	u_int eventbit;
> > +} event_table_t;
> 
> No typedefs, please.

OK, I've converted it to a plain "struct".

I think this code is just following PCMCIA style:

typedef struct pccard_mem_map { 
	u_char	map;
	u_char	flags;
	u_short	speed;
	u_long	static_start;
	u_int	card_start;
	struct resource *res;
} pccard_mem_map;

Any reason why this typedef and similar ones in ss.h 
are wanted? 

PCMCIA is also using u_xxx "weird data types" extensively.
