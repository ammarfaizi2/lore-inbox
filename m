Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267488AbUHPJQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbUHPJQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUHPJQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:16:29 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:48258 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S267488AbUHPJPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:15:44 -0400
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
From: Adrian Cox <adrian@humboldt.co.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16672.30991.27709.349218@cargo.ozlabs.ibm.com>
References: <200408160254.i7G2ss3S000656@harpo.it.uu.se>
	 <1092642051.959.56.camel@localhost>
	 <16672.30991.27709.349218@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1092647739.959.63.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 10:15:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 10:06, Paul Mackerras wrote:
> Adrian Cox writes:
> 
> > Pages should be marked coherent for the MPC106 as well as the MPC107,

> The MPC106 has an internal cache?  I had a quick look in the 106 and
> 107 manuals and I couldn't see in either one where it talks about a
> cache.  Do you know where I should be looking?

MPC106UM, section 8.1.3.1: PCI to System Memory Read Buffer (PCMRB)
MPC107UM, section 12.1.3.1.1: PCI to Local Memory Read Buffer (PCMRB)

It's not a big cache, but it's large enough to hold the transmit
descriptor of a pcnet32 ethernet. It's easy to miss this in the manual,
and I only noticed it when my first 7450 board wouldn't work with NFS
root.

- Adrian Cox
Humboldt Solutions Ltd.


