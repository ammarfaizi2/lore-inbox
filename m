Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUDNIgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbUDNIgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:36:22 -0400
Received: from mail.shareable.org ([81.29.64.88]:9376 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263975AbUDNIgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:36:12 -0400
Date: Wed, 14 Apr 2004 09:35:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au.ibm.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: PowerPC exec page protection
Message-ID: <20040414083550.GB8303@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414082355.GA8303@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<asm-ppc/pgtable.h> and <asm-ppc64/pgtable.h> both define the
following map of protection bits:

    #define __P000  PAGE_NONE
    #define __P001  PAGE_READONLY_X
    #define __P010  PAGE_COPY
    #define __P011  PAGE_COPY_X
    #define __P100  PAGE_READONLY
    #define __P101  PAGE_READONLY_X
    #define __P110  PAGE_COPY
    #define __P111  PAGE_COPY_X

    #define __S000  PAGE_NONE
    #define __S001  PAGE_READONLY_X
    #define __S010  PAGE_SHARED
    #define __S011  PAGE_SHARED_X
    #define __S100  PAGE_READONLY
    #define __S101  PAGE_READONLY_X
    #define __S110  PAGE_SHARED
    #define __S111  PAGE_SHARED_X

The _X flags seem wrongly placed, as bit 2 is the PROT_EXEC bit, not
bit 0.  Is the above intentional?

-- Jamie
