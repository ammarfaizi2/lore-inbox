Return-Path: <linux-kernel-owner+w=401wt.eu-S932137AbXARJua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbXARJua (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXARJua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:50:30 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51162 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbXARJu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:50:29 -0500
X-Originating-Ip: 74.109.98.130
Date: Thu, 18 Jan 2007 04:44:38 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Cedric Le Goater <clg@fr.ibm.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]  Add new categories of DEPRECATED and OBSOLETE.
In-Reply-To: <45AF3942.9070701@fr.ibm.com>
Message-ID: <Pine.LNX.4.64.0701180437430.8137@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701171745480.4740@CPE00045a9c397f-CM001225dbafb6>
 <45AF3942.9070701@fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Cedric Le Goater wrote:

> Robert P. J. Day wrote:
> >   Next to EXPERIMENTAL, add two new kernel config categories of
> > DEPRECATED and OBSOLETE.
>
> What about adding some printks when DEPRECATED and OBSOLETE are set
> ? like in print_tainted() for example.

i preferred to introduce this as a non-intrusive change, which didn't
*require* any change to actual source code or header files.  note that
you can add these two new categories (and any other categories you
can dream up) without changing *anything* else about the build
process.  and once those two categories are in the init/Kconfig file,
subsystem maintainers can, on their own time, make the appropriate
changes to their subsystems.  it's all perfectly voluntary.

also, code that's deprecated can still be tagged with
"__attribute__((deprecated))" in the source code.

rday
