Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbTI2Bmn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 21:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTI2Bmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 21:42:43 -0400
Received: from fmr04.intel.com ([143.183.121.6]:59882 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262779AbTI2Bmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 21:42:42 -0400
Subject: Re: HT not working by default since 2.4.22
From: Len Brown <len.brown@intel.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <20030928104654.GB9770@louise.pinerecords.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC870C@hdsmsx402.hd.intel.com>
	 <20030928104312.GA9770@louise.pinerecords.com>
	 <20030928104654.GB9770@louise.pinerecords.com>
Content-Type: text/plain
Organization: 
Message-Id: <1064799717.2532.8.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Sep 2003 21:41:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_NR_CPUS=4

See if cranking this up to 8 helps.
It looks like your BIOS defines empty processor slots
as processors that are present but disabled.

if this doesn't do it, please drop the output from
from dmidecode and acpidmp in a bugzilla and point me to it.

thanks,
-Len


On Sun, 2003-09-28 at 06:46, Tomas Szepe wrote:
> > > > Hmm, I happen to know of a system that fails to detect the 
> > > > sibling CPU(s) with CONFIG_ACPI_HT_ONLY set, whereas w/o it
> > > > "all fine running's."
> > > > 
> > > > Is this a bug?
> > > 
> > > Yes, could you file it on bugzilla.org Power management/acpi?
> > 
> > It seems 2.4.23-pre5 can't enable the sibling CPU even with
> > full ACPI enabled on this system...  .config attached,
> > relevant parts of dmesg follow:
> 
> Forgot to attach the .config, sorry.

