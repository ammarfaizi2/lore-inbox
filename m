Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWGUKgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWGUKgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWGUKgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:36:20 -0400
Received: from outmx003.isp.belgacom.be ([195.238.4.100]:27074 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161035AbWGUKgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:36:19 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to
	k(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Jeff Garzik <jgarzik@pobox.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
In-Reply-To: <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
References: <20060720190529.GC7643@lumumba.uhasselt.be>
	 <200607210850.17878.eike-kernel@sf-tec.de>
	 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>
	 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de>
	 <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 12:35:56 +0200
Message-Id: <1153478157.9489.30.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On vr, 2006-07-21 at 12:20 +0200, Jesper Juhl wrote:
> [snip]
> >  - better style of the size argument where correct,
> 
> Who says it's "better style" ?
Documentation/CodingStyle does :) (which in fact, I only noticed when I
was validating someone's remark that it would be a good idea to change
sizeof's)

"The preferred form for passing a size of a struct is the following:

        p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the pointer variable type
is changed but the corresponding sizeof that is passed to a memory
allocator is not."


> You can argue that   sizeof(type) is more readable.
> When reading the code you don't have to go lookup the type of ptr in
> sizeof(*ptr)  before you know what type the code is working with.


With friendly regards,
Takis

