Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbQKGVpE>; Tue, 7 Nov 2000 16:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQKGVoz>; Tue, 7 Nov 2000 16:44:55 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:58007 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129699AbQKGVos>; Tue, 7 Nov 2000 16:44:48 -0500
Date: Tue, 7 Nov 2000 22:44:33 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Chris Swiedler <chris.swiedler@sevista.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] protect processes from OOM killer
Message-ID: <20001107224433.C883@iapetus.localdomain>
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNMEADCPAA.chris.swiedler@sevista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNMEADCPAA.chris.swiedler@sevista.com>; from chris.swiedler@sevista.com on Tue, Nov 07, 2000 at 11:19:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 11:19:37AM -0500, Chris Swiedler wrote:
> Here's a small patch to allow a user to protect certain PIDs from death-
> by-OOM-killer. It uses the proc entry '/proc/sys/vm/oom_protect'; echo the
> PIDs to be protected:
> 
> echo 1 516 > /proc/sys/vm/oom_protect
Hmm, I'd prefer "echo 1 >/proc/516/oom_protect". Guess that's
out of the question because only /proc/sys should be used for
setting parameters?

Then maybe /proc/sys/proc should be populated so we can do
"echo 1 >/proc/sys/proc/516/oom_protect".

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
