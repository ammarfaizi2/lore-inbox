Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVDCWJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVDCWJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVDCWJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 18:09:10 -0400
Received: from smtpout.mac.com ([17.250.248.44]:17121 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261445AbVDCWJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 18:09:06 -0400
In-Reply-To: <1112559934.5268.9.camel@tiger>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Renate Meijer <kleuske@xs4all.nl>,
       linux-kernel@vger.kernel.org, Dag Arne Osvik <da@osvik.no>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Use of C99 int types
Date: Sun, 3 Apr 2005 18:08:42 -0400
To: Kenneth Johansson <ken@kenjo.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 03, 2005, at 16:25, Kenneth Johansson wrote:
> But is this not exactly what Dag Arne Osvik was trying to do ??
> uint_fast32_t means that we want at least 32 bits but it's OK with
> more if that happens to be faster on this particular architecture.
> The problem was that the C99 standard types are not defined anywhere
> in the kernel headers so they can not be used.

Uhh, so what's wrong with "int" or "long"?  On all existing archs
supported by linux, "int" is 32 bits, "long long" is 64 bits, and
"long" is an efficient word-sized value that can hold a casted
pointer.  I suppose it's theoretical that linux could be ported to
some arch where int is 16 bits, but so much stuff implicitly depends
on at least 32-bits in int that I think that's unlikely.  GCC will
generally do the right thing if you just tell it "int".

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


