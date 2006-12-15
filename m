Return-Path: <linux-kernel-owner+w=401wt.eu-S1752888AbWLOQwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbWLOQwd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbWLOQwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:52:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42296 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752885AbWLOQwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:52:32 -0500
Date: Fri, 15 Dec 2006 16:44:23 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.name>
Cc: Phillip Susi <psusi@cfl.rr.com>, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: interface for modems with out of band signalling
Message-ID: <20061215164423.26a47f14@localhost.localdomain>
In-Reply-To: <200612151709.48415.oliver@neukum.name>
References: <200612151514.00390.oliver@neukum.org>
	<4582C4FC.8040203@cfl.rr.com>
	<200612151709.48415.oliver@neukum.name>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, I am talking about how to support modems which don't have a
> command mode. These USB modems don't accept AT commands
> through the same channel as data. They take them encapsulated in special
> command messages to endpoint 0.
> How do I export this capability to user space? I am thinking about having
> two device nodes. But there may be a driver setting another precedent.
> Therefor I am asking.

ISDN4Linux provides a fake modem emulation in kernel space. The Nokia
phone drivers provide a user space manager which provides the interface.

So you've got precedents for both. If it's simply a case of splitting AT
commands off from the data and spotting guard bands and +++ you might
want to do it kernel side, if the second endpoint takes its own set of
phone control messages I guess its hairier.
