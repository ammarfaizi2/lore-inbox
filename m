Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVAQN2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVAQN2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVAQN2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:28:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61575 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262790AbVAQN1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:27:51 -0500
Subject: Re: permissions of /proc/tty/driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Viehmann <tv@beamnet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105949676.6304.50.camel@laptopd505.fenrus.org>
References: <41E80535.1060309@beamnet.de> <20050116120436.GA13906@lst.de>
	 <1105908524.12196.13.camel@localhost.localdomain>
	 <20050116222658.GA22364@lst.de>
	 <1105949676.6304.50.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105961207.12695.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 12:23:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 08:14, Arjan van de Ven wrote:
> On Sun, 2005-01-16 at 23:26 +0100, Christoph Hellwig wrote:
> > I know.  But that doesn't explain why we don't keep strict permissions
> > only on that file but on the directory.
> 
> ls -la on the file gives you the size maybe ?

I went for a dig in the archives

The original fix removed the tx/rx data from the file if you weren't
priviledged. Linus did the directory hack because he didn't want to
worry about drivers that got missed out/not fixed.

So there's a janitor project there - to go through all the tty/serial
drivers and make sure they don't give out excessively useful information
to non CAP_SYS_RAWIO users, then loosen permissions.

