Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWHOTUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWHOTUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWHOTUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:20:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1239 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965174AbWHOTUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:20:13 -0400
Subject: Re: Maximum number of processes in Linux
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Willy Tarreau <w@1wt.eu>, Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
	 <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com>
	 <20060815182219.GL8776@1wt.eu>
	 <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 21:19:44 +0200
Message-Id: <1155669584.3011.178.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Shows a consistent 6140.
> 

the default limit in proc scales with memory (to avoid really bad
stuff), you can oversize it to 2^16 if you want. 

Going over 2^16 is not too good an idea (16 bit counters overflow),
especially if you have hostile users (read: students) on the machine,
since this is the kind of scenario you can trigger on purpose.


