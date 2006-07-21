Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWGUKOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWGUKOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWGUKOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:14:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:28854 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161022AbWGUKOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:14:11 -0400
Date: Fri, 21 Jul 2006 13:14:10 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Panagiotis Issaris <takis@gna.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset tok(z|c)alloc.
In-Reply-To: <1153474342.9489.8.camel@hemera>
Message-ID: <Pine.LNX.4.58.0607211308590.25982@sbz-30.cs.Helsinki.FI>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
 <200607210850.17878.eike-kernel@sf-tec.de> 
 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
 <44C07CB2.1040303@pobox.com> <1153474342.9489.8.camel@hemera>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006, Panagiotis Issaris wrote:
> Ah okay. Up until now, I thought it would be okay to change the style of
> the code if it was listed in the CodingStyle document and in any other
> cause should be left untouched as it would be left to the maintainers
> personal preference. That's why I explicitly asked about the "if ((buf =
> kmalloc(...)==NULL) -> buf = kmalloc(...); if (!buf)" type of changes.
> 
> Ofcourse, I should have put cosmetic changes in a separate patch anyway.

At least Andrew seems to prefer cleaning up in the same patch. Anyway, I 
don't think Jeff meant that you shouldn't do any cleanups, but that you 
should try to respect the existing style as much possible. There are 
things that are almost generally agreed upon, such as removal of redundant 
typecasts, redundant wrappers, and moving assignment out of if statement 
expression. Formatting and the dreaded sizeof thing, however, 
are not, so it is best to keep them as-is.

				Pekka
