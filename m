Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUHDNMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUHDNMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUHDNMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:12:51 -0400
Received: from [213.146.154.40] ([213.146.154.40]:56546 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265224AbUHDNL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:11:27 -0400
Subject: Re: [PATCH][5/3][ARM] PCI quirks update for ARM
From: David Woodhouse <dwmw2@infradead.org>
To: dsaxena@plexity.net
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       akpm@osdl.org
In-Reply-To: <20040803193716.GA16737@plexity.net>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
	 <20040803193716.GA16737@plexity.net>
Content-Type: text/plain
Message-Id: <1091625077.4383.2728.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 04 Aug 2004 14:11:18 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 12:37 -0700, Deepak Saxena wrote:
> On Aug 03 2004, at 18:33, David Woodhouse was caught saying:
> > It's a pain in the arse to set up platform-specific PCI quirks -- you
> > have to put your platform-specific quirk into the generic (or at least
> > the architecture) array. This patch fixes that, allowing you to
> > DECLARE_PCI_FIXUP_HEADER() or DECLARE_PCI_FIXUP_FINAL() anywhere you
> > like.
> 
> Good idea.  Following is ARM patch.

Thanks. I did the rest of the architectures too -- it's all at 
bk://linux-mtd.bkbits.net/quirks-2.6

It probably doesn't want to go to Linus until after 2.6.8 is released,
but perhaps we could put it in the -mm tree until then?

I note that just about everyone has their own identical definition of
pci_fixup_ide_bases(). We should probably clean that up.

-- 
dwmw2

