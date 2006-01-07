Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWAGBBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWAGBBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWAGBBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:01:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:54217 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932486AbWAGBBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:01:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/4] Series to allow a "const" file_operations struct
Date: Sat, 7 Jan 2006 02:01:02 +0100
User-Agent: KMail/1.9.1
Cc: Eric Dumazet <dada1@cosmosbay.com>, arjan@infradead.org,
       linux-kernel@vger.kernel.org
References: <1136583937.2940.90.camel@laptopd505.fenrus.org> <43BEF338.3010403@cosmosbay.com> <20060106162913.7621895c.akpm@osdl.org>
In-Reply-To: <20060106162913.7621895c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601070201.02984.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 7. Januar 2006 01:29 schrieb Andrew Morton:
> > size vmlinux*
> >     text    data     bss     dec     hex filename
> > 2476156  522236  244868 3243260  317cfc vmlinux
> > 2588685  571348  246692 3406725  33fb85 vmlinux.old
>
> Confused.   Why should this result in an aggregate reduction in vmlinux
> size?

The size tool only displays the sum of .text, .data and .bss, but completely 
ignores other sections. So if you manage to move part of the object e.g.
into .rodata or .initdata, it will show a smaller size although the size of 
the actual vmlinux file stays the same.

Erics point was just about .data getting smaller, not about the bogus sum.

	Arnd <><
