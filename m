Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVKDNEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVKDNEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVKDNEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:04:44 -0500
Received: from [81.2.110.250] ([81.2.110.250]:37323 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751025AbVKDNEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:04:44 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131086585.4680.235.camel@gaston>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <1131086585.4680.235.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Nov 2005 13:34:57 +0000
Message-Id: <1131111297.26925.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-04 at 17:43 +1100, Benjamin Herrenschmidt wrote:
> > - HPA
> > - IRQ mask
> 
> Why do we need the above at all ? It always looked to me like a gross
> hack but then, I don't fully understand what the problem was on those
> old x86 that needed it :)

You can't do anything useful with some systems without disabling the HPA
because it is used to mask most of the drive at boot to hide from old
incompatible BIOS.

IRQ mask is on my todo list and looks quite easy. A small number of
controllers mishandle the case when the FIFO empties. Instead of
stalling the drive they dribble random numbers. 

> > ATIIXP
> > IT8172
> > OPTI621

Did initial drivers for those three yesterday

> > SL82C105

And that one last night/this morning although it (and the old one) both
need serialize to fix bugs.

Alan

