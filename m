Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVCDQoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVCDQoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVCDQoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:44:54 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:9336 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262936AbVCDQnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:43:08 -0500
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][3/26] IB/mthca: improve CQ locking part 1
X-Message-Flag: Warning: May contain useful information
References: <2005331520.cHJfJcRbBu1fFgB6@topspin.com>
	<4227AD34.4050002@pobox.com> <20050304005824.GA18411@kroah.com>
	<527jkonryr.fsf@topspin.com> <20050304163357.GB28179@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 04 Mar 2005 08:43:06 -0800
In-Reply-To: <20050304163357.GB28179@kroah.com> (Greg KH's message of "Fri,
 4 Mar 2005 08:33:58 -0800")
Message-ID: <521xavmkf9.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 16:43:06.0998 (UTC) FILETIME=[3DFE1160:01C520D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> What would pci_irq_sync() do exactly?

    Greg> Consolidate common code like this?  :)

I don't see how one can do that.  As I pointed out in my reply to
Jeff, it actually requires understanding how the driver uses the
different MSI-X vectors to know which vector we need to synchronize
against.  So it seems pci_irq_sync() would have to be psychic.

If we can figure out how to do that, maybe we can consolidate a lot
more code into an API like

	void do_what_i_mean(void);

;)

 - R.
