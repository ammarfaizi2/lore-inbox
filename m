Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265272AbUENNT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265272AbUENNT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUENNT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:19:28 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:25104 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265272AbUENNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:19:26 -0400
Date: Fri, 14 May 2004 14:19:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Fruhwirth Clemens <clemens-dated-1085404045.d167@endorphin.org>
Cc: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] AES i586 optimized, regparm fixed
Message-ID: <20040514141923.A24264@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Fruhwirth Clemens <clemens-dated-1085404045.d167@endorphin.org>,
	linux-kernel@vger.kernel.org,
	Christophe Saout <christophe@saout.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	James Morris <jmorris@redhat.com>
References: <20040514130724.GA8081@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040514130724.GA8081@ghanima.endorphin.org>; from clemens-dated-1085404045.d167@endorphin.org on Fri, May 14, 2004 at 03:07:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 03:07:24PM +0200, Fruhwirth Clemens wrote:
> The patch posted yesterday has had an issue with CONFIG_REGPARM. The
> following patch corrects this issue and works for both cases
> CONFIG_REGPARM=y||n. Thanks to Christophe Saout, who pointed out the
> solution almost instantly. The patch does not apply Christophe's patch, but
> rather forces the interface back to regparm(0).

We usually use asmlinkage instead of __attribute__((regparm(0))).  while
it's not nessecary for x86-specific code to abstract this out it at least
looks cleaner.  BTW, is the assembly code shared with some other project?
If not it might be a good idea to kill the ifdefs in there.

