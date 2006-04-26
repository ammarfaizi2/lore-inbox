Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWDZUjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWDZUjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWDZUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:39:52 -0400
Received: from [198.99.130.12] ([198.99.130.12]:45762 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750722AbWDZUjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:39:52 -0400
Date: Wed, 26 Apr 2006 15:40:09 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060426194009.GA9845@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060420090514.GA9452@osiris.boeblingen.de.ibm.com> <444797F8.6020509@fujitsu-siemens.com> <1146083202.10211.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146083202.10211.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 04:26:42PM -0400, Charles P. Wright wrote:
> I have a similar local patch that I've been using.  I think it would be
> worthwhile to have an extra bit in the bitmap that says what to do with
> calls that fall outside the range [0, __NR_syscall].  That way the
> ptrace monitor can decide whether it is useful to get informed of these
> "bogus" calls.

The bit needs to be somewhere, but I think sticking it in the syscall
bitmask is a bad idea.  Mixing apples and oranges, as it were.
Sticking it in the op is better, even though that's a bit of apples
and oranges as well.

Another alternative would be to make it an option and set it with
PTRACE_SETOPTIONS.

				Jeff
