Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWHHRcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWHHRcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWHHRcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:32:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6794 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965013AbWHHRcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:32:08 -0400
Subject: Re: How to lock current->signal->tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060808164127.GA11392@intel.com>
References: <1155050242.5729.88.camel@localhost.localdomain>
	 <44D8A97B.30607@linux.intel.com>
	 <1155051876.5729.93.camel@localhost.localdomain>
	 <20060808164127.GA11392@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 18:50:05 +0100
Message-Id: <1155059405.5729.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-08 am 09:41 -0700, ysgrifennodd Luck, Tony:
> unaligned accesses at all is rather controversial.  So its a 50-50
> shot whether I'll fix it by adding the mutex_lock/mutex_unlock
> around the use of current->signal->tty, or just rip this out and
> just leave the printk().

Personally I'd just rip it out full stop. Its trivial to use kprobes and
friends to audit such things if there is a performance concern.

Alan

