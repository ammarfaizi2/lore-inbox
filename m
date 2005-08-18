Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVHRXkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVHRXkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVHRXkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 19:40:31 -0400
Received: from ozlabs.org ([203.10.76.45]:60639 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932406AbVHRXkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 19:40:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17157.7275.960362.923238@cargo.ozlabs.ibm.com>
Date: Fri, 19 Aug 2005 09:40:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, <hch@infradead.org>,
       <davem@davemloft.net>, "Gala Kumar K.-galak" <galak@freescale.com>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@ozlabs.org>, <zach@vmware.com>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
In-Reply-To: <A4C8B92D-B390-4BF8-A6D5-106ACBD0E716@freescale.com>
References: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
	<A4C8B92D-B390-4BF8-A6D5-106ACBD0E716@freescale.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala writes:

> So after all of this its not clear to me if its acceptable to kill  
> all users of <asm/segment.h> in the kernel and to move code that  
> exists in <asm/segment.h> to <asm/uaccess.h> for arch's that need it.

<asm/segment.h> doesn't describe any part of the user/kernel ABI, so
we should be OK to kill it.  I would say we should remove the ppc and
ppc64 versions of it once 2.6.13 is out, and offer the other arch
maintainers a patch that moves their stuff as you suggest.  I think
also we could submit patches to remove the places where it is included
in generic kernel code post 2.6.13.

Paul.
