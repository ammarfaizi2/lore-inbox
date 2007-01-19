Return-Path: <linux-kernel-owner+w=401wt.eu-S932774AbXASR1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbXASR1Q (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXASR1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:27:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49858 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbXASR1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:27:16 -0500
Subject: Re: unable to mmap /dev/kmem
From: Arjan van de Ven <arjan@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nadia Derbey <Nadia.Derbey@bull.net>, Franck Bui-Huu <fbuihuu@gmail.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0701191704510.7577@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net>
	 <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
	 <45B08B17.3060807@bull.net>
	 <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
	 <1169225824.3055.507.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0701191704510.7577@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 19 Jan 2007 18:27:09 +0100
Message-Id: <1169227629.3055.525.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 17:12 +0000, Hugh Dickins wrote:
> On Fri, 19 Jan 2007, Arjan van de Ven wrote:
> > On Fri, 2007-01-19 at 16:33 +0000, Hugh Dickins wrote:
> > > Though I do wonder whether
> > > it was safe to change its behaviour at that stage: more evidence that
> > > few have actually been using mmap of /dev/kmem. 
> > 
> > ... and maybe we should just kill /dev/kmem entirely... it seems mostly
> > used by rootkits but very few other things, if any at all...
> 
> It was discourteous of me not to CC you: I thought you might say that ;)
> Though so long as /dev/mem support remains, /dev/kmem might as well?

they're not the same; for a long time, /dev/mem on actual memory
returned zeros... so you couldn't use it for rootkits ;)
(that got "fixed" a while ago)

> And be kept as a CONFIG_ option under DEBUG_KERNEL thereafter?

config option is fine I suppose... I assume distros will be smart enough
to turn it off ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

