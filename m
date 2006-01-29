Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWA2NJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWA2NJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWA2NJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:09:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10396 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750962AbWA2NJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:09:33 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060129122901.GX3777@stusta.de>
References: <1138312694656@2gen.com> <1138312695665@2gen.com>
	 <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	 <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu>  <20060129122901.GX3777@stusta.de>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 14:09:08 +0100
Message-Id: <1138540148.3002.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> You are taking the wrong approach.
> 
> The _only_ question that matters is:
> Why is it technically impossible to do the same in userspace?
> 
> If it's technically possible to do the same in userspace, it must not be 
> done in the kernel.


that is not a reasonable statement because...
1) you can do all of tcp/ip in userspace just fine
2) you can do the NFS server in userspace
3) ...
4) ...

there are reasons why things that can be done in userspace sometimes
still make sense to do in kernel space, performance could be one of
those reasons, being unreasonably complex in userspace is another.

Identity management to some degree belongs in the kernel, simply because
identity *enforcing* is in the kernel. Some things related to security
need to be in the kernel at least partially just to avoid a LOT of hairy
issues and never ending series of security holes due to the exceptional
complexity you get.



