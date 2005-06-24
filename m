Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVFXUXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVFXUXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFXUXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:23:54 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:54225 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262602AbVFXUWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:22:52 -0400
Message-ID: <42BC6B99.6060305@brturbo.com.br>
Date: Fri, 24 Jun 2005 17:22:49 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Sean Bruno <sean.bruno@dsl-only.net>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, trivial@rustcorp.com.au
Subject: [PATCH-GIT] Re: PROBLEM 2.6.12-git6  CX88
References: <1119642377.3180.20.camel@home-lap>
In-Reply-To: <1119642377.3180.20.camel@home-lap>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------020904080305070104080604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904080305070104080604
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sean,

	It is an already seen error that occurs only with gcc 4.0. It's
correction was already sent to Andrew Morton to be applied on the -mm
series.
	I'm enclosing a patch for solving it.

Sean Bruno wrote:
> Attempted to compile 2.6.12 with git6 today received the following error
> on the cx88 module:
> drivers/media/video/cx88/cx88-core.c:548: error: static declaration of
> ‘cx88_pci_irqs’ follows non-static declaration
> drivers/media/video/cx88/cx88.h:438: error: previous declaration of
> ‘cx88_pci_irqs’ was here
> Also, here is my gcc version info:
> [root@home-desk linux-2.6.12]# gcc -v
> Using built-in specs.
> Target: x86_64-redhat-linux
> gcc version 4.0.0 20050519 (Red Hat 4.0.0-8)
              +++++
		^

Mauro.

--------------020904080305070104080604
Content-Type: text/x-patch;
 name="v4l_cx88_pci_irqs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_cx88_pci_irqs.patch"

 drivers/media/video/cx88/cx88.h |    1 -
 1 files changed, 1 deletion(-)
--- drivers/media/video/cx88/cx88.h.old	2005-06-24 17:13:51.000000000 -0300
+++ drivers/media/video/cx88/cx88.h	2005-06-24 17:14:05.000000000 -0300
@@ -435,7 +435,6 @@ struct cx8802_dev {
 /* ----------------------------------------------------------- */
 /* cx88-core.c                                                 */
 
-extern char *cx88_pci_irqs[32];
 extern char *cx88_vid_irqs[32];
 extern char *cx88_mpeg_irqs[32];
 extern void cx88_print_irqbits(char *name, char *tag, char **strings,

--------------020904080305070104080604--
