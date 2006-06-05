Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751077AbWFEMuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWFEMuA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWFEMuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:50:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14763 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751077AbWFEMt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:49:59 -0400
Subject: Re: [patch, -rc5-mm3] fix irqpoll some more
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060605084938.GA31915@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net>
	 <1149497459.23209.39.camel@localhost.localdomain>
	 <20060605084938.GA31915@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 14:05:08 +0100
Message-Id: <1149512708.30554.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately we've got a load of handlers that just blindly say "Yes I
handled something" so they bogusly cause completion to be assumed.

We'd actually have to know if the IRQ source had "gone away" on the chip
I fear.

