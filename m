Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265803AbUE1Ez0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUE1Ez0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 00:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUE1Ez0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 00:55:26 -0400
Received: from ozlabs.org ([203.10.76.45]:62658 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265803AbUE1EzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 00:55:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16566.50644.847967.850463@cargo.ozlabs.ibm.com>
Date: Fri, 28 May 2004 14:53:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PPC64] Remove silly debug path from get_vsid()
In-Reply-To: <20040528035537.GT2603@schnapps.adilger.int>
References: <20040528031659.GC15922@zax>
	<20040528035537.GT2603@schnapps.adilger.int>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:

> so presumably if you don't select CONFIG_PPCDBG it is also a no-op unless
> the compiler is broken and doesn't optimize away "if (0)" stanzas.  The
> original construct gives you the option to enable this particular debugging
> at runtime (without necessarily enabling all debugging at one time) if wanted.

And the effect of suddenly changing your VSID calculation algorithm in
mid-stream is pretty catastrophic.  There is no sensible reason
wanting to be able to turn this on and off at runtime.  This is not
just some extra checking.

Paul.
