Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSLKFku>; Wed, 11 Dec 2002 00:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSLKFku>; Wed, 11 Dec 2002 00:40:50 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:33796 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S264729AbSLKFkt>;
	Wed, 11 Dec 2002 00:40:49 -0500
To: linux-kernel@vger.kernel.org
Subject: incompatable pointer type warnings on some archs
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 11 Dec 2002 00:48:26 -0500
Message-ID: <m37kehm7h1.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see that find_next_zero_bit() has a first arg of void* in about half
of the archs and unsigned long* in the rest (incl asm-i386/bitops.h).

Looking at incompatable pointer type warnings in a recent compile, I
found one where the caller was passing a u64*, thus the error.

Should all of the archs use a void* for this, or is there some reason
not to?

test_and_set_bit() and test_and_clear_bit() also have the same issue.

-JimC

