Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWHQABG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWHQABG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWHQABG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:01:06 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:3037 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932142AbWHQABF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:01:05 -0400
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>, linuxppc-dev@ozlabs.org,
       mingo@elte.hu, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1155771487.11312.114.camel@localhost.localdomain>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	 <17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	 <yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
	 <1155318983.5337.2.camel@localhost.localdomain>
	 <1155771487.11312.114.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 17:00:59 -0700
Message-Id: <1155772859.15360.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 01:38 +0200, Benjamin Herrenschmidt wrote:
> > You might take a peek at the patch set here:
> > http://sr71.net/~jstultz/tod/ for a somewhat rough powerpc conversion to
> > CONFIG_GENERIC_TIME.
> 
> Afaik, as-is, this patch will remove updating of the various bits used
> by the vDSO for userland gettimeofday without actually removing the vdso
> itself. Thus, with a recent glibc, it will break gettimeofday,
> clock_gettime, .... Pretty bad :)

Hey Ben,
	I appreciate your looking over my patch. You are correct, the
conversion is a bit rough and I've not yet been able to work on the
powerpc vDSO, although I'd like to get it working so any help or
suggestions would be appreciated (is there a reason the vDSO is written
in ASM?).

If you have any other concerns w/ that patch, or the generic timekeeping
code, please let me know and I'll do what I can to address them.

thanks
-john

