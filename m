Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQKGUsR>; Tue, 7 Nov 2000 15:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQKGUsH>; Tue, 7 Nov 2000 15:48:07 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:22704 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129239AbQKGUr4>; Tue, 7 Nov 2000 15:47:56 -0500
Date: Tue, 7 Nov 2000 21:47:52 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Chris Swiedler <chris.swiedler@sevista.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] protect processes from OOM killer
Message-ID: <20001107214752.J7204@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNMEADCPAA.chris.swiedler@sevista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNMEADCPAA.chris.swiedler@sevista.com>; from chris.swiedler@sevista.com on Tue, Nov 07, 2000 at 11:19:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 11:19:37AM -0500, Chris Swiedler wrote:
> Here's a small patch to allow a user to protect certain PIDs from death-
> by-OOM-killer. It uses the proc entry '/proc/sys/vm/oom_protect'; echo the
> PIDs to be protected:

Please base it upon my OOM-Killer-API patch.

        http://www.tu-chemnitz.de/~ioe/oom_kill_api.patch

This will reduce your patch to an simple module (but you have to
manage refcounting yourself!) and give the user a choice, which
one to use.

If someone provides an OOM-Handler himself, please use my API to
allow better testing and comparing.

PS: Of course it applies cleanly against test10 as well ;-)

Thanks and Regards

Ingo Oeser
-- 
To the systems programmer, users and applications
serve only to provide a test load.
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
