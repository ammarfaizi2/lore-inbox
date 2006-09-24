Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWIYLRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWIYLRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWIYLRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:17:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751124AbWIYLRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:17:15 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45150CD7.4010708@aknet.ru>
References: <45150CD7.4010708@aknet.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 24 Sep 2006 02:53:38 +0200
Message-Id: <1159059219.3093.276.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 14:30 +0400, Stas Sergeev wrote:
> Hi Andrew.
> 
> I am not sure at all whether this patch is appreciated
> or not. The on-list query yielded no results, but I have
> to try. :)
> 
> This patch removes the MNT_NOEXEC check for the PROT_EXEC
> mappings. 

so you remove a security check ...

> That allows to mount tmpfs with "noexec" option
> without breaking the existing apps, which is what debian
> wants to do for sequrity reasons:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386945

... to add a "security" feature?

sounds like the wrong tradeoff!

If you can mmap PROT_EXEC the "noexec" mount option doesn't mean
anything! Because a elf binary loader is easily written in
perl/shell/whatever, the kernel "x" bit is just a convenience there!
The PROT_EXEC check at least makes it a bit harder to do anything like
this; not impossible obviously

Greetings,
   Arjan van de Ven

