Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbUKUHDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUKUHDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUKUHDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:03:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:10909 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261863AbUKUHDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:03:47 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <419FF598.9080606@us.ibm.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <1100917635.9398.12.camel@localhost.localdomain>
	 <1100934567.3669.12.camel@gaston>
	 <1100954543.11822.8.camel@localhost.localdomain>
	 <419FD58A.3010309@us.ibm.com> <1100995616.27157.44.camel@gaston>
	 <419FF598.9080606@us.ibm.com>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 18:03:02 +1100
Message-Id: <1101020582.27157.59.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I thought about that when coding this up and thought it would
> be better to simply have the function do what it advertises and no
> more. Seems strange that a function called pci_block_config_access
> would go and do a bunch of pci config accesses, but we can
> certainly add it if you like.

Well, considering that when blocked, reads return data from the cache,
it makes sense to fill the cache when blocking ... or we'll end up
returning crap.

Ben.


