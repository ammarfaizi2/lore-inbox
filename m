Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271365AbTGWWa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271367AbTGWWaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:30:25 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:4847 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271365AbTGWWaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:30:17 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307240035.38502.bernie@develer.com>
References: <200307232046.46990.bernie@develer.com>
	 <20030723132256.58ee50e7.davem@redhat.com>
	 <20030723212755.A608@infradead.org> <200307240035.38502.bernie@develer.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058999786.6890.21.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 23:37:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 23:35, Bernardo Innocenti wrote:
> It's a sequence of 6 instructions, 18 bytes long, clobbering 4 registers.
> The compiler cannot see around it.
> This takes 18*11 = 198 bytes just for invoking the 'current'
> macro so many times.

Unless you support SMP I'm not sure I understand why m68k nommu changed
from using a global for current_task ?

