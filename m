Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVCODgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVCODgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVCODgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:36:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:63148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262225AbVCODfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:35:17 -0500
Date: Mon, 14 Mar 2005 19:34:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: alan@redhat.com, torvalds@osdl.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
Message-Id: <20050314193447.47ca6754.akpm@osdl.org>
In-Reply-To: <4235ED35.1000405@aknet.ru>
References: <42348474.7040808@aknet.ru>
	<20050313201020.GB8231@elf.ucw.cz>
	<4234A8DD.9080305@aknet.ru>
	<Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
	<4234B96C.9080901@aknet.ru>
	<20050314192943.GG18826@devserv.devel.redhat.com>
	<4235ED35.1000405@aknet.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> Alan Cox wrote:
>  >> Alan, can you please apply that to an -ac
>  >> tree?
>  > Ask Andrew Morton as it belongs in the -mm tree
>  Actually I tried that already.

I added this patch to -mm.

> Andrew
>  had nothing against that patch personally,
>  as well as Linus, but after all that didn't
>  work:
>  http://lkml.org/lkml/2005/1/3/260
> 
>  So it can't be applied to -mm, and not
>  depending on the kgdb-ga patch allowed for
>  some extra optimization.

The rule is:

- If the patch patches something which is in Linus's kernel, prepare a
  diff against Linus's latest kernel.

- If the patch patches something which is only in -mm, prepare a patch
  against -mm.

In this case, I merged the patch prior to the kgdb patch and then fixed
up the fallout.

(If that causes kgdb to break in non-obvious-to-me ways then I might come
calling "help".  We'll see)
