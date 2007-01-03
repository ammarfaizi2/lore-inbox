Return-Path: <linux-kernel-owner+w=401wt.eu-S1749667AbXACKVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1749667AbXACKVQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 05:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbXACKVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 05:21:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37322 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1749667AbXACKVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 05:21:15 -0500
Date: Wed, 3 Jan 2007 10:29:44 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: s0348365@sms.ed.ac.uk, torvalds@osdl.org, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070103102944.09e81786@localhost.localdomain>
In-Reply-To: <200701030212.l032CDXe015365@harpo.it.uu.se>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's a good suggestion. Earlier C3s didn't have cmov so it's 
> not entirely unlikely that cmov in C3-2 is broken in some cases.
> Configuring for P5MMX or 486 should be good safe alternatives.

The proper fix for all of this mess is to fix the gcc compiler suite to
actually generate i686 code when told to use i686. CMOV is an optional
i686 extension which gcc uses without checking. In early PIV days it made
sense but on modern processors CMOV is so pointless the bug should be
fixed. At that point an i686 kernel would contain i686 instructions and
actually run on all i686 processors ending all the i586 pain for most
users and distributions.

Unfortunately the compiler people don't appear to care about their years
old bug.

Alan
