Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVLaPBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVLaPBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVLaPBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:01:53 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15628 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964980AbVLaPBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:01:52 -0500
Date: Sat, 31 Dec 2005 15:58:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Al Boldi <a1426z@gawab.com>, Willy Tarreau <willy@w.ods.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, barryn@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051231145822.GB15993@alpha.home.local>
References: <200512302306.28667.a1426z@gawab.com> <200512310759.02962.a1426z@gawab.com> <20051231073817.GZ15993@alpha.home.local> <200512311702.20525.a1426z@gawab.com> <1136039178.2901.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136039178.2901.25.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 03:26:18PM +0100, Arjan van de Ven wrote:
> On Sat, 2005-12-31 at 17:02 +0300, Al Boldi wrote:
> 
> > Shouldn't it be possible to disable overcommit completely, thus giving kswapd 
> > a break from running wild trying to find something to swap/page, which is 
> > the reason why the system gets unstable going over 95% in your example.
> 
> shared mappings make this impractical. To disable overcommit completely,
> each process would need to account for all its own shared libraries, eg
> each process gets glibc added etc. You'll find that on any
> non-extremely-stripped system you then end up with much more memory
> needed than you have ram.

Arjan, is this true even for read-only mappings such as shared libs ?
It seems to me that those ones can precisely be mapped once because
they are areas the process cannot extend. Am I wrong ?

Willy

