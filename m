Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTIHOZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTIHOZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:25:47 -0400
Received: from havoc.gtf.org ([63.247.75.124]:38351 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262360AbTIHOZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:25:45 -0400
Date: Mon, 8 Sep 2003 10:25:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <willy@debian.org>,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel header separation
Message-ID: <20030908142545.GA3926@gtf.org>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org> <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk> <20030905211604.GB16993@codepoet.org> <20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk> <1063028303.32473.333.camel@hades.cambridge.redhat.com> <1063030329.21310.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063030329.21310.32.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 03:12:10PM +0100, Alan Cox wrote:
> On Llu, 2003-09-08 at 14:38, David Woodhouse wrote:
> > > __u8 has a very precise meaning defined by Linux.  If you're including
> > > a Linux header. that's what you need to worry about.
> > 
> > It's a kernel-private type. If we're aiming for a clean set of headers,
> > then ideally we should avoid gratuitously defining our own types when
> > standards already exist.
> 
> __u8 is intended to be used by non kernel stuff for headers. Thats why
> "__u8" not "u8" - so it doesnt pollute the sacred posix name space and
> have us lynched by glibc people

Well, strictly speaking, __u8 is an internal gcc not kernel type.

Now that C99 has defined size-based types, I would prefer that we start
using those...  They are a bit more verbose than "u8" but I think look
better, and more important, are more portable in the long term than __u8.

Whenever I see "__u8", I think "non-standard, gcc-specific dependency"

	Jeff



