Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVDFUDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVDFUDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVDFUDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:03:13 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:60559 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262306AbVDFUDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:03:00 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] [linux-2.6-bk] UML compile broken!
Date: Wed, 6 Apr 2005 22:01:41 +0200
User-Agent: KMail/1.7.2
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, jdike@karaya.com,
       lkml <linux-kernel@vger.kernel.org>
References: <1112793369.32726.4.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1112793369.32726.4.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504062201.41991.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 15:16, Anton Altaparmakov wrote:
> Uml compile is btoken in current linus bk 2.6:
>
>   CC      arch/um/kernel/ptrace.o
> arch/um/kernel/ptrace.c: In function `send_sigtrap':
> arch/um/kernel/ptrace.c:324: warning: implicit declaration of function
> `SC_IP'
> arch/um/kernel/ptrace.c:324: error: union has no member named `tt'
> arch/um/kernel/ptrace.c:324: error: union has no member named `tt'
> arch/um/kernel/ptrace.c:324: error: invalid lvalue in unary `&'
> make[1]: *** [arch/um/kernel/ptrace.o] Error 1
> make: *** [arch/um/kernel] Error 2
>
> My .config is attached.  I suspect it is because I am not compiling in
> TT support and only SKAS...
Well, good guess - you're getting more and more used with UML!

Yes, the fix is in -mm.

Quoting from -rc2-mm1 announce:

+uml-fix-compilation-for-__choose_mode-addition.patch

 UML fix

Andrew, can you merge it now, if you want, after Anton verifies it's the 
correct fix indeed for his problem? I *do* expect his situation to fail 
without the patch, but just to be more sure.

However, I recall with 2.6.11-bk7 a slightly different problem, when compiling 
only SKAS mode in, and I don't think this has been fixed:

[uml-devel] [UML/2.6] -bk7 tree does not run when compiled as SKAS-only

I'm forwarding that mail to LKML and you, Andrew - for your -rc regressions 
mail folder.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


