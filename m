Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030606AbWAGWAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030606AbWAGWAP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWAGWAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:00:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:37519 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030606AbWAGWAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:00:13 -0500
Date: Sat, 7 Jan 2006 14:00:05 -0800
From: "Kurtis D. Rader" <kdrader@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, Bernd Eckenfels <be-news06@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-ID: <20060107220005.GB13433@us.ibm.com>
References: <20060104221023.10249eb3.rdunlap@xenotime.net> <E1EuPZg-0008Kw-00@calista.inka.de> <20060105111105.GK20809@redhat.com> <20060107214439.GA13433@us.ibm.com> <1136670488.2936.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136670488.2936.44.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 22:48:08, Arjan van de Ven wrote:
> On Sat, 2006-01-07 at 13:44 -0800, Kurtis D. Rader wrote:
> > 
> > Another very common situation is a system which fails to boot due to
> > failures to find the root filesystem. This can happen because of device name
> > slippage, root disk not being found, the proper HBA driver isn't present in
> 
> mount by label fixes some of that but not all

The "not all" case is important. Especially since the potential causes
of being unable to find the root filesystem keep increasing with each
new capability.  And it isn't just failures involving finding the rootfs
that can be problematic to debug without more context than is on the
final screen image.

> > the initrd image, etc. The customer calls us and reports the last thing they
> > see on the screen:
> 
> fwiw it would make sense (at least for distros) to make this print a
> more helpful text about potential causes etc, rather than just making
> people say "the kernel paniced".

That might be useful for people who don't have support contracts. It
wouldn't help customer support teams like I'm a member of. We know what
those potential reasons are. The challenge is having enough context to
quickly determine which possible explanation accounts for the failure.
Ideally every customer would have a serial console configured. But a)
most customers don't/won't/can't configure one and b) on many systems a
serial console is not available.
