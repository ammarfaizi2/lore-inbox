Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280947AbRK1Wjn>; Wed, 28 Nov 2001 17:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280938AbRK1Wjd>; Wed, 28 Nov 2001 17:39:33 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:27922 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S280937AbRK1WjY>; Wed, 28 Nov 2001 17:39:24 -0500
Message-Id: <200111282239.fASMdMY82422@aslan.scsiguy.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel's X86 ffs() doesn't work on constants.
Date: Wed, 28 Nov 2001 15:39:22 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you attempt to call ffs(SOME_CONSTAT) in an x86 kernel under
Linux, you get messages like this:

{standard input}: Assembler messages:
{standard input}:14864: Error: suffix or operands invalid for `bsf'

I'm not enough of a GCC asm syntax guru to understand why the
compiler/assembler doesn't handle this, but it is hightly anoying.

"Why not just code in the constant bit offset?", you ask?  If
the constant the bit offset is based on is ever changed, I must
recognize that the change occured and change the second constant.
For constants that are maintained outside of my code, I'd rather
code the dependency once and let the compiler ensure that the constants
are in sync.

--
Justin
