Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWHPXiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWHPXiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWHPXiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:38:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:6328 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751255AbWHPXiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:38:50 -0400
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>, linuxppc-dev@ozlabs.org,
       mingo@elte.hu, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1155318983.5337.2.camel@localhost.localdomain>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	 <17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	 <yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
	 <1155318983.5337.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 01:38:07 +0200
Message-Id: <1155771487.11312.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You might take a peek at the patch set here:
> http://sr71.net/~jstultz/tod/ for a somewhat rough powerpc conversion to
> CONFIG_GENERIC_TIME.

Afaik, as-is, this patch will remove updating of the various bits used
by the vDSO for userland gettimeofday without actually removing the vdso
itself. Thus, with a recent glibc, it will break gettimeofday,
clock_gettime, .... Pretty bad :)

Ben.


