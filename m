Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281817AbRKVX3q>; Thu, 22 Nov 2001 18:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281816AbRKVX3h>; Thu, 22 Nov 2001 18:29:37 -0500
Received: from pat.uio.no ([129.240.130.16]:35218 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281817AbRKVX33>;
	Thu, 22 Nov 2001 18:29:29 -0500
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <3BFD7633.2525641E@pobox.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Nov 2001 00:29:23 +0100
In-Reply-To: <3BFD7633.2525641E@pobox.com>
Message-ID: <shsn11eidv0.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == J Sloan <J> writes:

     > Hello, In 2.4.15-pre8 I applied the tux2 patches to take it for
     > a spin - well, it's insanely fast, thanks Ingo - but I am
     > having a problem with the sun rpc module:

     > depmod gives the following result on -pre8 and -pre9:

     > depmod: *** Unresolved symbols in
     > /lib/modules/2.4.15-pre9/kernel/net/sunrpc/sunrpc.o depmod:
     > atomic_dec_and_lock_R648ef859

atomic_dec_and_lock is one of those architecture-dependent functions
that can either be defined in arch/* or in lib/dec_and_lock.c.
Without the relevant details from your .config file, it is not obvious
to figure out exactly which combination is screwed.

Cheers,
  Trond
