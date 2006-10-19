Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946209AbWJSQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946209AbWJSQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946199AbWJSQgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:36:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17605 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946209AbWJSQgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:36:12 -0400
Subject: Re: [PATCH 1/1 try #2] Char: correct pci_get_device changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl, Amit Gud <gud@eth.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <1966866new061818079@muni.cz>
References: <1966866new061818079@muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 17:36:54 +0100
Message-Id: <1161275814.17335.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 16:44 +0200, ysgrifennodd Jiri Slaby:
> correct pci_get_device changes
> 
> Commits 881a8c120acf7ec09c90289e2996b7c70f51e996 and
> efe1ec27837d6639eae82e1f5876910ba6433c3f corrects pci device matching in
> only one way; it no longer oopses/crashes, despite hotplug is not solved in
> these changes.
> 
> Whenever pci_find_device -> pci_get_device change is performed, also
> pci_dev_get and pci_dev_put should be in most cases called to properly
> handle hotplug. This patch does exactly this thing -- increase refcount to
> let kernel know, that we are using this piece of HW just now.
> 
> It affects moxa and rio char drivers.
> 
> Cc: <R.E.Wolff@BitWizard.nl>
> Cc: Amit Gud <gud@eth.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

