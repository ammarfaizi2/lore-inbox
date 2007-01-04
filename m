Return-Path: <linux-kernel-owner+w=401wt.eu-S1030265AbXADXTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbXADXTW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbXADXTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:19:21 -0500
Received: from sd291.sivit.org ([194.146.225.122]:3061 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030268AbXADXTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:19:20 -0500
Subject: Re: [PATCH] Fix __ucmpdi2 in v4l2_norm_to_name()
From: Stelian Pop <stelian@popies.net>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <1167951548.12012.55.camel@praia>
References: <1167909014.20853.8.camel@localhost.localdomain>
	 <20070104144825.68fec948.akpm@osdl.org>  <1167951548.12012.55.camel@praia>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 05 Jan 2007 00:19:17 +0100
Message-Id: <1167952757.20260.6.camel@voyager.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 04 janvier 2007 à 20:59 -0200, Mauro Carvalho Chehab a écrit :

> > The largest value we use here is 0x02000000.  Perhaps v4l2_std_id shouldn't
> > be 64-bit?
> Too late to change it to 32 bits. It is at V4L2 userspace API since
> kernel 2.6.0. We can, however use this approach as a workaround, with
> the proper documentation.

Maybe with a BUG_ON(id > UINT_MAX) ?

Linus, do you want a patch for this or will you take the _ucmppdi2 ppc
patch as per http://lkml.org/lkml/2006/12/17/46 instead ?

Thanks,

Stelian.
-- 
Stelian Pop <stelian@popies.net>

