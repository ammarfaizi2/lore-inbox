Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVBNVn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVBNVn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVBNVn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:43:26 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:43920 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261566AbVBNVnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:43:12 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
X-Message-Flag: Warning: May contain useful information
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>
	<4211013E.6@pobox.com> <52hdke29sh.fsf@topspin.com>
	<20050214200043.GA15868@havoc.gtf.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 14 Feb 2005 13:42:40 -0800
In-Reply-To: <20050214200043.GA15868@havoc.gtf.org> (Jeff Garzik's message
 of "Mon, 14 Feb 2005 15:00:43 -0500")
Message-ID: <52d5v224z3.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Feb 2005 21:42:40.0426 (UTC) FILETIME=[1B8E08A0:01C512DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> That's an MSI bug.

    Jeff> A current PCI driver -should- be using pci_request_regions().

Hmm... I'm not sure everyone would agree with that.  It does make
sense that the MSI-X core wants to make sure that it owns the MSI-X
table without having someone else stomp on it.

 - R.
