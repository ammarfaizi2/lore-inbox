Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTLMCac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTLMCac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:30:32 -0500
Received: from main.gmane.org ([80.91.224.249]:22443 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263281AbTLMCaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:30:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha
 (2.6.0-test11)
Date: Sat, 13 Dec 2003 03:27:06 +0100
Message-ID: <yw1xisklwiyt.fsf@kth.se>
References: <20031213003841.GA5213@wang-fu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:YWUmrWThA/LW8ln8XooRfJFaMe8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Poznick <kraken@drunkmonkey.org> writes:

> First off, I'm not positive that this patch is correct or not, but I'd
> like to pick the brains of people in the know, to find if I'm
> approaching this in the right way.
>
> I've been unable to use modules on my Alpha with 2.6.0-test*.  modprobe
> (from module-init-tools 0.9.15-pre3) would claim an invalid module
> format, and the kernel would tell me "Unknown relocation: 1"  Relocation
> 1 on Alpha is R_ALPHA_REFLONG, and sure enough, readelf -r on one of the
> modules showed many, many uses of it.  From looking at
> arch/alpha/kernel/module.c, it appeared that while R_ALPHA_REFQUAD was
> handled, R_ALPHA_REFLONG was not.  R_ALPHA_REFQUAD's handling looked
> simple enough, so I made the change which is inlined below.

Which gcc and binutils versions do you use?  I've seen some variation
in which relocations they produce.

-- 
Måns Rullgård
mru@kth.se

