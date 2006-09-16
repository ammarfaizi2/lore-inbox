Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWIPQi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWIPQi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWIPQi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:38:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37290 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964839AbWIPQiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:38:54 -0400
Subject: Re: [PATCH] mxser: PCI refcounts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <450BF0A1.4040807@gmail.com>
References: <1158329578.29932.38.camel@localhost.localdomain>
	 <450BF0A1.4040807@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Sep 2006 18:02:38 +0100
Message-Id: <1158426158.6069.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-16 am 14:39 +0159, ysgrifennodd Jiri Slaby:
> Alan Cox wrote:
> > Switch to pci ref counts for mxser when handling PCI devices. Use
> > pci_get_device and drop the reference when we finish and unload.
> 
> Please, don't do that. These all drivers need to be rewritten to pci probing 
> (for this one I have a patch, but I waited for confirmation of previous 
> patchset, but nothing has come, so perhaps I will clone it as NEW/EXPERIMENTAL 
> 1.9.1-with-pci-probing-driver) and when pci_find_device is there, we can `grep 
> -r` it to know, which drivers need that. The same holds for zoran cards, which 
> somebody wanted to play with (and rework), but as I can see, nothing happened :/.

Well if they need pci probing updates perhaps we should either apply the
alternative patches and see what breaks, or delete the driver and see
who screams.

Alan

