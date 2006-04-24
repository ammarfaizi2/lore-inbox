Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDXODb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDXODb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDXODb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:03:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58822 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750760AbWDXODa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:03:30 -0400
Subject: RE: Problems with EDAC coexisting with BIOS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ong, Soo Keong" <soo.keong.ong@intel.com>
Cc: "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
In-Reply-To: <C1989F6360C8E94B9645F0E4CF687C08C1E9EF@pgsmsx412.gar.corp.intel.com>
References: <C1989F6360C8E94B9645F0E4CF687C08C1E9EF@pgsmsx412.gar.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 15:13:46 +0100
Message-Id: <1145888026.29648.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 21:59 +0800, Ong, Soo Keong wrote:
> Alan,
> 
> Have you understood how the errors are connected to the interrupts
> (either SMI, NMI, SCI)?

I believe so

> When does EDAC read the error status? Periodical or upon interrpt by
> errors?

Periodically currently. The sf development tree has some code for
handling the NMI case but this isn't actually useful because an NMI can
occur half way through a PCI config transaction.

Alan

