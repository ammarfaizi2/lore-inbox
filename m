Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbTI2F3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 01:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTI2F3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 01:29:20 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:41678 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261920AbTI2F3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 01:29:19 -0400
Date: Mon, 29 Sep 2003 07:29:09 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Len Brown <len.brown@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: HT not working by default since 2.4.22
Message-ID: <20030929052909.GA18126@louise.pinerecords.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC870C@hdsmsx402.hd.intel.com> <20030928104312.GA9770@louise.pinerecords.com> <20030928104654.GB9770@louise.pinerecords.com> <1064799717.2532.8.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064799717.2532.8.camel@dhcppc4>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [len.brown@intel.com]
> 
> > CONFIG_NR_CPUS=4
> 
> See if cranking this up to 8 helps.
> It looks like your BIOS defines empty processor slots
> as processors that are present but disabled.
> 
> if this doesn't do it, please drop the output from
> from dmidecode and acpidmp in a bugzilla and point me to it.

Indeed, raising CONFIG_NR_CPUS to 8 solved the problem
even for the CONFIG_ACPI_HT_ONLY case (which wouldn't
work in 2.4.22-ac*).

Do you need any more info on this system or will this do?

-- 
Tomas Szepe <szepe@pinerecords.com>
