Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTK1OFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTK1OFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:05:00 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:31411 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262283AbTK1OE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:04:58 -0500
Message-ID: <3FC75603.6020808@softhome.net>
Date: Fri, 28 Nov 2003 15:04:51 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
References: <Wt8p.1R5.13@gated-at.bofh.it> <Wti7.2fc.19@gated-at.bofh.it> <WAjQ.83K.37@gated-at.bofh.it> <WAte.8iX.5@gated-at.bofh.it> <WACW.a9.19@gated-at.bofh.it> <WCuZ.2Tm.11@gated-at.bofh.it> <WCOd.3u0.1@gated-at.bofh.it>
In-Reply-To: <WCOd.3u0.1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> That ends up writing uninitialised kernel data to (unprivileged) user
> space.  So would strcpy() used in that situation.
> 

   I used to use:

    char buf[MAX];
     ...
    buf[MAX-1] = 0; /* zero terminate */
    strncpy(buf, src, MAX-1);

   This is safe regarding both 0 termination and 0 padding rest of string.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

