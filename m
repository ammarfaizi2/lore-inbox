Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVC0AF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVC0AF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 19:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVC0AF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 19:05:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26067 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261349AbVC0AF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 19:05:56 -0500
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
	-fs/ext2/
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-os <linux-os@analogic.com>, Arjan van de Ven <arjan@infradead.org>,
       ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	 <1111825958.6293.28.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 19:05:55 -0500
Message-Id: <1111881955.957.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 00:54 +0100, Jesper Juhl wrote:
> I'd say that the general rule should
> be "don't check for NULL first unless you *know* the pointer will be NULL
> >50% of the time"... 

How about running the same tests but using likely()/unlikely() for the
'1 in 50' cases?

Lee

