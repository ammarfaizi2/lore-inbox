Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVINO1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVINO1s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVINO1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:27:48 -0400
Received: from isilmar.linta.de ([213.239.214.66]:34984 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965189AbVINO1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:27:48 -0400
Date: Wed, 14 Sep 2005 16:27:46 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Pantelis Antoniou <panto@intracom.gr>,
       Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
Message-ID: <20050914142746.GA14742@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-kernel@vger.kernel.org, Pantelis Antoniou <panto@intracom.gr>,
	Dan Malek <dan@embeddededge.com>
References: <20050830024840.GA5381@dmt.cnet> <20050901085319.GB6285@isilmar.linta.de> <20050914141131.GA6830@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914141131.GA6830@dmt.cnet>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 11:11:31AM -0300, Marcelo Tosatti wrote:
> On Thu, Sep 01, 2005 at 10:53:19AM +0200, Dominik Brodowski wrote:
> 
> > > +typedef struct  {
> > > +	u_int regbit;
> > > +	u_int eventbit;
> > > +} event_table_t;
> > 
> > No typedefs, please.
> 
> OK, I've converted it to a plain "struct".

Thanks.

> I think this code is just following PCMCIA style:
> 
> typedef struct pccard_mem_map { 
> 	u_char	map;
> 	u_char	flags;
> 	u_short	speed;
> 	u_long	static_start;
> 	u_int	card_start;
> 	struct resource *res;
> } pccard_mem_map;
>
> Any reason why this typedef and similar ones in ss.h 
> are wanted? 

There's no reason for this being typedef'ed, and it is contrary to the
kernel source CodingStyle. However, all pcmcia code was external at first,
that's why the CodingStyle differs.

> PCMCIA is also using u_xxx "weird data types" extensively.

Unfortunately, yes. However, I'm in the process of adapting it to the kernel
CodingStyle. I don't change something from "u_int" to "unsigned int" just for
the naming of it, though, but when I'm in the same area fixing one thing or
another, I try to take care of it. New structs, like struct pcmcia_device, 
already adhere the normal kernel policy on structs and typedefs.

Thanks,
	Dominik
