Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVFRKbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVFRKbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 06:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVFRKbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 06:31:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:62160 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261934AbVFRKbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 06:31:35 -0400
Date: Sat, 18 Jun 2005 12:36:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Keith Owens <kaos@ocs.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12
In-Reply-To: <20050618065911.GH8907@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0506181231410.2653@dragon.hyggekrogen.localhost>
References: <21446.1119073126@ocs3.ocs.com.au> <Pine.LNX.4.58.0506172255280.2268@ppc970.osdl.org>
 <20050618065911.GH8907@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005, Willy Tarreau wrote:

> On Fri, Jun 17, 2005 at 11:05:28PM -0700, Linus Torvalds wrote:
>  
> > Because it's extracted as a regular file (instead of tar knowing that it's 
> > a comment header), you will now have a file called "pax_global_header" 
> > that has the contents
> 
> I guess it will end up in dontdiff quickly :-)
> 
If Linus accepts the patch below, then yes :-)


Add pax_global_header to Documentation/dontdiff
Kernel tar-archives created by git contain an extended header with the git 
commit ID that was used to generate the tar-tree. If your tar is older 
than 1.14 then this extended header will be extracted as a regular file 
called pax_global_header. Patches should never be generated against this 
file, so it should be listed in dontdiff.

Signed-off-by: Jesper Juhl
---

 Documentation/dontdiff |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.12-orig/Documentation/dontdiff	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/Documentation/dontdiff	2005-06-18 12:30:25.000000000 +0200
@@ -138,3 +138,4 @@
 wanxlfw.inc
 uImage
 zImage
+pax_global_header



