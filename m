Return-Path: <linux-kernel-owner+w=401wt.eu-S1751340AbXAFKw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbXAFKw7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 05:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbXAFKw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 05:52:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54327 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbXAFKw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 05:52:58 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Arjan van de Ven <arjan@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <459F70FC.6090908@vmware.com>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>
	 <1168064710.20372.28.camel@localhost.localdomain>
	 <20070106071424.GB11232@elte.hu>  <459F70FC.6090908@vmware.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 06 Jan 2007 02:52:31 -0800
Message-Id: <1168080751.3101.129.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 01:50 -0800, Zachary Amsden wrote:
> Ingo Molnar wrote:
> > * Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> >   
> >> +EXPORT_SYMBOL(clts);
> >> +EXPORT_SYMBOL(read_cr0);
> >> +EXPORT_SYMBOL(write_cr0);
> >>     
> >
> > mark these a _GPL export. Perhaps even mark the symbol deprecated, to be 
> > unexported once we fix raid6.
> >   
> 
> read / write cr0 must not be GPL, since kernel_fpu_end uses them

but kernel_fpu_begin() is _GPL already so this is just symmetry...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

