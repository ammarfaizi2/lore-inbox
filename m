Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVLaO0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVLaO0b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVLaO0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:26:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932291AbVLaO0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:26:30 -0500
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       barryn@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <200512311702.20525.a1426z@gawab.com>
References: <200512302306.28667.a1426z@gawab.com>
	 <200512310759.02962.a1426z@gawab.com>
	 <20051231073817.GZ15993@alpha.home.local>
	 <200512311702.20525.a1426z@gawab.com>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 15:26:18 +0100
Message-Id: <1136039178.2901.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 17:02 +0300, Al Boldi wrote:

> Shouldn't it be possible to disable overcommit completely, thus giving kswapd 
> a break from running wild trying to find something to swap/page, which is 
> the reason why the system gets unstable going over 95% in your example.

shared mappings make this impractical. To disable overcommit completely,
each process would need to account for all its own shared libraries, eg
each process gets glibc added etc. You'll find that on any
non-extremely-stripped system you then end up with much more memory
needed than you have ram.


