Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266678AbUFWVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUFWVWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUFWVUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:20:51 -0400
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:15032 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261763AbUFWVQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:16:10 -0400
Subject: Re: [PATCH 2.6.7-mm1] MBR centralization
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040623140650.46f184bd.akpm@osdl.org>
References: <1088025348.2213.32.camel@localhost.localdomain>
	 <20040623140650.46f184bd.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1088028275.2213.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 24 Jun 2004 00:04:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2004-06-23 at 23:06, Andrew Morton wrote:
> FabF <fabian.frederick@skynet.be> wrote:
> >
> > +/*Master boot record magic numbers*/
> > +#define MSDOS_MBR_SIGNATURE 0xaa55
> > +#define MSDOS_MBR(p) le16_to_cpu((u16)*p) == MSDOS_MBR_SIGNATURE
> 
> I'd make this
> 
> /*
>  * Check for MSDOS Master Boot Record signature
>  */
> static inline int msdos_mbr(u16 v)
> {
> 	return le16_to_cpu(v) == 0xaa55;
> }
That means I would have to cast from all msdos_partition calls 
e.g. msdos_mbr((u16)*(data+510)) .Is this the right way ?

Regards,
FabF

