Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTDQPdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTDQPds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:33:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4224 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261727AbTDQPds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:33:48 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
To: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 17 Apr 2003 16:47:45 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), alan@lxorguk.ukuu.org.uk (Alan Cox),
       mochel@osdl.org (Patrick Mochel),
       andrew.grover@intel.com (Grover Andrew),
       benh@kernel.crashing.org (Benjamin Herrenschmidt),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20030417150926.GA25402@gtf.org> from "Jeff Garzik" at Apr 17, 2003 11:09:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The video BIOS on a card often contains information that is found
> > > -nowhere- else.  Not in the chip docs.  Not in a device driver.
> > > Such information can and does vary from board-to-board, such as RAM
> > > timings, while the chip remains unchanged.
> > 
> > Incidently, what happens if we:
> > 
> > * Suspend
> > * Swap VGA card with another one
> > * Restore
> 
> When it breaks, you get to keep both pieces.
> 
> That's a "Don't Do That" issue for any hardware between suspend
> and resume.

Hmm, well what about with a PCI hotswap capable board - presumably
then we could have the situation where a new VGA card appears that we
_have_ to POST?

John.
