Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272312AbTGaDpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 23:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272356AbTGaDpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 23:45:32 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:25571 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S272312AbTGaDpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 23:45:31 -0400
Date: Thu, 31 Jul 2003 05:45:27 +0200
From: Frank v Waveren <fvw@var.cx>
To: linux-kernel@vger.kernel.org
Cc: Andries.Brouwer@cwi.nl, linux-crypto@nl.linux.org
Subject: 2.6.0-test2+Util-linux/cryptoapi
Message-ID: <1059621603HIC.fvw@tracks.var.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was giving 2.6.0-test2 a spin, and run into a few issues with
loopback crypto:

First of all, in util-linux 2.12 the keybits option is gone, and the
number of keybits is fixed to 256 (even though some algorithms in the
kernel support more). Is this a temporary thing or a design decision?

Moving to the slightly more ontopic stuff for lk@vger: Is access to
the cryptoapi algorithms exposed to userspace yet? I wanted to have
losetup/mount hash the passphrase before passing it to the kernel, and
it seems silly to actually put a separate hashing algorithm in
util-linux when they're there in the kernel anyway.

Thirdly, has the encryption setup changed again since 2.4.x with hvr's
testing cryptoapi stuff? I have a filesystem encrypted with 256 bits
serpent, yet it won't decrypt using 2.6.0-test2 and util-linux 2.12.

Lastly: Why the move from a /proc/crypto directory containing files
for all the algorithms to one monolithic /proc/crypto file? Isn't the
former a lot nicer from the userspace programmer's point of view?


-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|chello.nl] ICQ#10074100            1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
