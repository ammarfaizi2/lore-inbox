Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUAFCOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUAFCOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:14:31 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:12700 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265251AbUAFCOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:14:30 -0500
Date: Tue, 6 Jan 2004 03:14:21 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: mremap() bug IMHO not in 2.2
Message-ID: <20040106021421.GI4987@louise.pinerecords.com>
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet> <20040105181053.6560e1e3.grundig@teleline.es> <20040105182607.GB2093@pasky.ji.cz> <20040105225508.GM2093@pasky.ji.cz> <Pine.LNX.4.58.0401051532510.5737@home.osdl.org> <200401052358.i05NwWIe010594@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401051604550.5970@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051604550.5970@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-05 2004, Mon, 16:08 -0800
Linus Torvalds <torvalds@osdl.org> wrote:

> The only page that should matter is likely the one at 0xC0000000, where 
> there can be extra complications from the fact that we use 4MB pages for 
> the kernel, so when fork/exit tries to walk the page table, it would get 
> bogus results.
> 
> Still, I'd expect that to lead to a triple fault (and thus a reboot) 
> rather than any elevation of privileges..

Hmmm... so what about non-x86?

> Interesting, in any case. Good catch from whoever found it.

Impressive, yes.

-- 
Tomas Szepe <szepe@pinerecords.com>
