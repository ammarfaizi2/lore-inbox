Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWGUJch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWGUJch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 05:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWGUJch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 05:32:37 -0400
Received: from outmx001.isp.belgacom.be ([195.238.5.51]:34531 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161017AbWGUJch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 05:32:37 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset tok(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
In-Reply-To: <44C07CB2.1040303@pobox.com>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
	<200607210850.17878.eike-kernel@sf-tec.de> 
	<84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
	<44C07CB2.1040303@pobox.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 11:32:22 +0200
Message-Id: <1153474342.9489.8.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-imss-version: 2.032
X-imss-result: Passed
X-imss-scanInfo: M:P L:E SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:3.51.1032(14006.000)
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On vr, 2006-07-21 at 03:05 -0400, Jeff Garzik wrote:
> Pekka Enberg wrote:
> > On 7/21/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> >> > -     if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
> >> > +     handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
> >> > +     if (!handle)
> >> >               return NULL;
> >>
> >> sizeof(*handle)?
> > 
> > In general, yes. However, some maintainers don't like that, so I would
> > recommend to keep them as-is unless you get a clear ack from the
> > maintainer to change it.
> 
> Strongly agreed.  Follow the style of the existing code as closely as 
> possible, and resist the temptation of making little "improvements" 
> while you are doing a task...

Ah okay. Up until now, I thought it would be okay to change the style of
the code if it was listed in the CodingStyle document and in any other
cause should be left untouched as it would be left to the maintainers
personal preference. That's why I explicitly asked about the "if ((buf =
kmalloc(...)==NULL) -> buf = kmalloc(...); if (!buf)" type of changes.

Ofcourse, I should have put cosmetic changes in a separate patch anyway.

With friendly regards,
Takis

