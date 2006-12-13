Return-Path: <linux-kernel-owner+w=401wt.eu-S965077AbWLMTEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWLMTEM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWLMTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:04:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37734 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965077AbWLMTEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:04:11 -0500
Subject: Re: SM501: core (mfd) driver
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Dooks <ben-fbdev@fluff.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20061213175143.GA11394@home.fluff.org>
References: <20061213155134.GA10097@home.fluff.org>
	 <1166030491.27217.844.camel@laptopd505.fenrus.org>
	 <20061213175143.GA11394@home.fluff.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 13 Dec 2006 20:04:06 +0100
Message-Id: <1166036646.27217.870.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 17:51 +0000, Ben Dooks wrote:
> > > +
> > > +	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
> > > +
> > > +	dev_dbg(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
> > > +		gate, clock, mode);
> > > +
> > > +	msleep(16);
> > 
> > you're missing a PCI posting flush here
> > (if you don't know what this is please ask)
> 
> Is this a read from an device register to cause the PCI writes
> to happen?

yup

>  Would reading SM501_POWER_MODE_CONTROL be ok, or does
> it require a different register?

any register is ok, you can read the same one just fine.


greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

