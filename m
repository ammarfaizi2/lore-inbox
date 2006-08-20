Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWHTPbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWHTPbe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWHTPbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:31:34 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:61132 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750820AbWHTPbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:31:34 -0400
Date: Mon, 21 Aug 2006 00:33:17 +0900 (JST)
Message-Id: <20060821.003317.63131005.anemo@mba.ocn.ne.jp>
To: zippel@linux-m68k.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [NTP 5/9] add time_adjust to tick length
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060810001114.706731000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
	<20060810001114.706731000@linux-m68k.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 02:01:51 +0200, zippel@linux-m68k.org wrote:
> This folds update_ntp_one_tick() into second_overflow() and adds
> time_adjust to the tick length, this makes time_next_adjust unnecessary.
> This slightly changes the adjtime() behaviour, instead of applying it to
> the next tick, it's applied to the next second.
...
> -/* Don't completely fail for HZ > 500.  */
> -int tickadj = 500/HZ ? : 1;		/* microsecs */

The tickadj is used by cris, frv, m32r, m68k, mips and sparc.  This
patch would break build on those platforms.

I have not looked at this patch closely yet.  Just a report.
---
Atsushi Nemoto
