Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSHXUbj>; Sat, 24 Aug 2002 16:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSHXUbj>; Sat, 24 Aug 2002 16:31:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48388 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316728AbSHXUbi>;
	Sat, 24 Aug 2002 16:31:38 -0400
Date: Sat, 24 Aug 2002 21:35:49 +0100
From: Matthew Wilcox <willy@debian.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Consolidate include/asm/fcntl.h into include/linux/fcntl.h
Message-ID: <20020824213549.H29958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think this is a bad idea -- when doing a new port, it's easier to fill
in the bits with the current scheme rather than with your proposed scheme.
There is one part which I like:

-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */

All of these can go, nobody's been using them since kernel 2.0.  I took
out the last vestiges of them from locks.c earlier in 2.5.  None of the
BSDs have them either.

-- 
Revolutions do not require corporate support.
