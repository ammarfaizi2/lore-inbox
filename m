Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132957AbRDERov>; Thu, 5 Apr 2001 13:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132956AbRDERol>; Thu, 5 Apr 2001 13:44:41 -0400
Received: from pausch-140.htp-tel.de ([212.59.61.140]:5870 "EHLO
	pausch-140.htp-tel.de") by vger.kernel.org with ESMTP
	id <S132953AbRDERod>; Thu, 5 Apr 2001 13:44:33 -0400
From: Peter Rottengatter <peter@rottengatter.de>
To: linux-kernel@vger.kernel.org
Reply-To: peter@rottengatter.de
Subject: AIC7xxx in Kernel 2.4.3
Date: Wed, 04 Apr 2001 01:11:01 +0200 (CEST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <E14kZx0-00079C-00@>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

This driver seems to be pretty broken, the way it is. It does not compile.
The new author, Justin T. Gibbs, has been careful in avoiding to mention
his e-mail address in his code :-( Hence the post to this list.

As the first problem, the compile stops in aicasm_gram.c because in
aicasm_gram.y the author forgot a function prototype. The compiler assumed
an implicit declaration which was incompatible with the final definition
of the function. The fix was easy of course.

Next, the code #includes a file called db1/db.h. To me this seems to be a
header file for the Berkeley database version 1. Debian does not provide
development packages for this rather old version, in fact, not even my
old cds from earlier linux distributions had this file. db2/db.h does not
work.

Possibly people by accident had this old file on their machine when the
new kernel was test-compiled. So far, all kernels I compiled by myself did
not seem to depend on any even remotely unusual header files. So this
surprises me a lot. Does not look good for a release that's meant to be
"stable", does it ?

Cheers  Peter



