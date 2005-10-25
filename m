Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVJYSKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVJYSKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 14:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVJYSKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 14:10:13 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54917 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932280AbVJYSKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 14:10:12 -0400
Subject: Re: 2.6.14-rc5-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Avuton Olrich <avuton@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3aa654a40510251055r33b2b8a5kbd5c53471a243851@mail.gmail.com>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <3aa654a40510251055r33b2b8a5kbd5c53471a243851@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Oct 2005 19:39:00 +0100
Message-Id: <1130265540.25191.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-10-25 at 10:55 -0700, Avuton Olrich wrote:
> On 10/24/05, Andrew Morton <akpm@osdl.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> 
> After upgrading to 2.6.14-rc5-mm1 I have been greeted with:
> 
> PCI-Bridge- Detected Parity Error on 0000:00:08.0 0000:00:08.0

> ... I probably get a new one every minute or so. Is this new, perhaps
> part of the new EDAC stuff? And what kind of adverse effect does this
> have on my computer (the actual parity error)?

If the parity error is real then it would indicate a bad PCI transfer
has occurred and data corrupted in the transfer. Unfortunately because
some vendors don't use PCI parity checking much and some card vendors
don't debug their products except on that OS there are some cards that
generate spurious parity errors.

Can you send an lspci -vxx. That'll help the EDAC folk build up a view
of what needs to be blacklisted.

Alan

