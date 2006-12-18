Return-Path: <linux-kernel-owner+w=401wt.eu-S1753742AbWLRKdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbWLRKdF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbWLRKdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:33:05 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41411 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbWLRKdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:33:04 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 05:28:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove logically superfluous comparisons from Kconfig
 files.
In-Reply-To: <20061218102653.GA23947@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612180527440.22930@localhost.localdomain>
References: <Pine.LNX.4.64.0612180509010.22527@localhost.localdomain>
 <20061218102653.GA23947@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006, Russell King wrote:

> On Mon, Dec 18, 2006 at 05:14:01AM -0500, Robert P. J. Day wrote:
> >   Remove Kconfig comparisons of the form FUBAR || FUBAR=n, since they
> > appear to be superfluous.
>
> config FOO
> 	tristate 'foo'
> 	depends on BAR || BAR=n
>
> is not superfluous.  The allowed states for FOO with the above construct
> are (assuming modules are enabled):
>
> 	BAR	FOO
> 	Y	Y,M,N
> 	M	M,N
> 	N	Y,M,N

ah, ok, i get it now.

> Also, you create some constructs such as:
>
>         depends on && PCI
>
> which is obviously wrong.

whoops, sorry, i didn't even notice that.

rday
