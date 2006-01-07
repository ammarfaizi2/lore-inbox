Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030600AbWAGVsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbWAGVsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbWAGVsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:48:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29922 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030600AbWAGVsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:48:16 -0500
Subject: Re: oops pauser. / boot_delayer
From: Arjan van de Ven <arjan@infradead.org>
To: "Kurtis D. Rader" <kdrader@us.ibm.com>
Cc: Dave Jones <davej@redhat.com>, Bernd Eckenfels <be-news06@lina.inka.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060107214439.GA13433@us.ibm.com>
References: <20060104221023.10249eb3.rdunlap@xenotime.net>
	 <E1EuPZg-0008Kw-00@calista.inka.de> <20060105111105.GK20809@redhat.com>
	 <20060107214439.GA13433@us.ibm.com>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 22:48:08 +0100
Message-Id: <1136670488.2936.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 13:44 -0800, Kurtis D. Rader wrote:
> On Thu, 2006-01-05 06:11:05, Dave Jones wrote:
> > On Thu, Jan 05, 2006 at 08:30:16AM +0100, Bernd Eckenfels wrote:
> >  > Randy.Dunlap <rdunlap@xenotime.net> wrote:
> >  > > This one delays each printk() during boot by a variable time
> >  > > (from kernel command line), while system_state == SYSTEM_BOOTING.
> >  >
> >  > This sounds a bit like a aprils fool joke, what it is meant to do? You can
> >  > read the messages in the bootlog and use the scrollback keys, no?
> > 
> > could be handy for those 'I see a few messages that scroll, and the
> > box instantly reboots' bugs.  Quite rare, but they do happen.
> 
> Another very common situation is a system which fails to boot due to
> failures to find the root filesystem. This can happen because of device name
> slippage, root disk not being found, the proper HBA driver isn't present in

mount by label fixes some of that but not all

> the initrd image, etc. The customer calls us and reports the last thing they
> see on the screen:

fwiw it would make sense (at least for distros) to make this print a
more helpful text about potential causes etc, rather than just making
people say "the kernel paniced".


