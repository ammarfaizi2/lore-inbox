Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWFMIey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWFMIey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 04:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWFMIey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 04:34:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:22372 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750731AbWFMIey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 04:34:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZsgC3J1Xgycwllmw8VxvHLedZZZDeYXsmvJcXnu5kn2TTM1gXdIIz5ds1sF3h6T7ZWB5YJiNagKtTt2XkEDo6WlpvsAggGq4kt6OFHMb1oiBj+uGq/iksjMCpdA6sdnGRQiwknaeEzNyXOCPQfIraBscpV8nuD6mOzt/Y4uVvk=
Message-ID: <cda58cb80606130134h4f74a4b8ndd977a89942c8933@mail.gmail.com>
Date: Tue, 13 Jun 2006 10:34:53 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Andy Whitcroft" <apw@shadowen.org>
Subject: Re: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <448DA530.7050604@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448D1117.8010407@innova-card.com> <448D9577.3040903@shadowen.org>
	 <cda58cb80606121021w22207ef6yf6dfcbf428b144c3@mail.gmail.com>
	 <448DA530.7050604@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/6/12, Andy Whitcroft <apw@shadowen.org>:
> Franck Bui-Huu wrote:
> > Hi Andy
> >
> > 2006/6/12, Andy Whitcroft <apw@shadowen.org>:
> >
> >>
> >> In my mind the positive option is selecting for code supporting EXTREME
> >> so it seems to make sense to use that option.
> >
> >
> > well I find it confusing because in my mind, something like this seems
> > more logical.
> >
> > #ifndef CONFIG_SPARSEMEM_STATIC
> > static struct mem_section *sparse_index_alloc(int nid)
> > {
> >        return alloc_bootmem_node(...);
> > }
> > #else
> > static struct mem_section *sparse_index_alloc(int nid)
> > {
> >        /* nothing to do here, since it has been statically allocated */
> >        return 0;
> > }
> > #endif
>
> But also in this case the code in the first stanza is only applicable to
> SPARSEMEM EXTREME, therefore its also logical to say
>

Well I don't think so. Please show me which part of this code is
_only_ applicable to EXTREME.

The only thing that makes it applicable to EXTREME is not in the code
but rather in the Kconfig script:

        config SPARSEMEM_EXTREME
                def_bool y
                depends on SPARSEMEM && !SPARSEMEM_STATIC

-- 
               Franck
