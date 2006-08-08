Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWHHPZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWHHPZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWHHPZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:25:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18330 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964941AbWHHPZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:25:18 -0400
Subject: Re: How to lock current->signal->tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, sds@tycho.nsa.gov,
       jack@suse.cz, dwmw2@infradead.org, tony.luck@intel.com,
       jdike@karaya.com, James.Bottomley@HansenPartnership.com
In-Reply-To: <44D8A97B.30607@linux.intel.com>
References: <1155050242.5729.88.camel@localhost.localdomain>
	 <44D8A97B.30607@linux.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 16:44:36 +0100
Message-Id: <1155051876.5729.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-08 am 08:10 -0700, ysgrifennodd Arjan van de Ven:
> > Unfortunately:
> > 	Dquot passes the tty to tty_write_message without locking
> > 	arch/ia64/kernel/unanligned seems to write to it without locking
> 
> these two have absolutely no business at all using anything tty.... they should
> just use printk with KERN_EMERG or whatever

Dquot does - it writes to the controlling tty of the process exceeding
quota . That is standard Unix behaviour

