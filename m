Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTDQOpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbTDQOpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:45:22 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6272 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261664AbTDQOpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:45:21 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304171459.h3HExMBa000217@81-2-122-30.bradfords.org.uk>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 17 Apr 2003 15:59:22 +0100 (BST)
Cc: mochel@osdl.org (Patrick Mochel), andrew.grover@intel.com (Grover Andrew),
       benh@kernel.crashing.org (Benjamin Herrenschmidt),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1050586549.31414.41.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 17, 2003 02:35:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Trying to figure out if we need to POST or not for different
> > hardware, based what the driver knows, is going to become quite a
> > mess real fast. I don't want to deal with the pain, and would
> > rather take the high ground, even if it means suffering in the
> > short term.
> 
> Short, long and forever. I agree we want drivers to be able to say
> "Don't POST I can hack this one", however we need to accept the real
> world that most hardware wants posting and that in many cases its
> what the windows driver does anyway.

One scenario we haven't covered is that we have a VGA card in a box,
which we don't care about being re-initialised after a suspend/resume.

A lot of cluster nodes have vga cards in them just so that they boot,
and you can plug a monitor and keyboard in to change BIOS settings.

The machines are never accessed except over the LAN in normal use, but
it's quite possible that you'd want to suspend the whole cluster
overnight, for example, or at least some nodes which were not in use,
and you wouldn't care about the VGA card being restored.

John.
