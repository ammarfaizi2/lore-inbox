Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbSKVGx4>; Fri, 22 Nov 2002 01:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKVGxz>; Fri, 22 Nov 2002 01:53:55 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:17370 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266795AbSKVGxz>; Fri, 22 Nov 2002 01:53:55 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15837.55031.816780.418357@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 22 Nov 2002 16:04:23 +0900
To: "dan carpenter" <error27@email.com>
Cc: linux-kernel@vger.kernel.org, smatch-kbugs@lists.sourceforge.net,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [LIST] large local declarations
In-Reply-To: <20021121215458.8534.qmail@email.com>
References: <20021121215458.8534.qmail@email.com>
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan carpenter writes:
> The function with the largest variable is riocontrol().  It is used
> deliberately for some weird hardware.  According to the comment,
> "it's hardware like this that really gets on [the author's] tits."

> 524736	 drivers/char/rio/rioctrl.c 1784 riocontrol

That variable is static.

                                         /* It's hardware like this that really gets on my tits. */
                                         static unsigned char copy[sizeof(struct DpRam)];

