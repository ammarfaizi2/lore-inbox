Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUKYE6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUKYE6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 23:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbUKYE6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 23:58:18 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:32359 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262972AbUKYE5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 23:57:14 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: akpm@osdl.org
Subject: Re: [PATCH] UML - Build cleanups
Date: Thu, 25 Nov 2004 04:53:18 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
References: <200411242305.iAON5qbn005388@ccure.user-mode-linux.org>
In-Reply-To: <200411242305.iAON5qbn005388@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411250453.18844.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 November 2004 00:05, Jeff Dike wrote:
> Uml-specific patch (which requires a mainline hook, mailed separately).
Andrew, drop this please... it's totally unneeded and the changelog is wrong.

> This patch avoid the linking kludge which leaves kbuild link vmlinux and
> then link it with libc inside linux. This kludge has the big problem of
> making kallsyms break, since the kallsyms pass is done on a completely
> different binary than the running one.

Jeff, sometimes you should upgrade changelogs... also, I'm working on Kbuild & 
UML interaction, so please send me Kbuild related patches, to avoid 
inconveniences like rejects for me and let me clean up patches...

In particular, this patch reverts some changes I did and especially readds 
this, which is a residual from when we set EXTRAVERSION in arch/um/Makefile 
so that the dependency was needed.

> +include/linux/version.h: arch/$(ARCH)/Makefile
> +

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
