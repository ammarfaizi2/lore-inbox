Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVBOLGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVBOLGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVBOLGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:06:21 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:49056 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261680AbVBOLGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:06:17 -0500
Date: Tue, 15 Feb 2005 22:06:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       ak@suse.de, willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-Id: <20050215220614.68c4e11e.sfr@canb.auug.org.au>
In-Reply-To: <20050215095153.GB13952@wotan.suse.de>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
	<20050215095153.GB13952@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Tue, 15 Feb 2005 10:51:53 +0100 Andi Kleen <ak@suse.de> wrote:
>
> I don't think this will work for sparc64/s390/UML etc.
> They cannot access kernel data inside KERNEL_DS. You would need to use
> compat_alloc_user_space() for ru

.. and, presumably, for info as well.  Interestingly, this code
came directly from sparc64 ...

However, if you are right, there are quite a few other compat sys calls
that should not be working either.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
