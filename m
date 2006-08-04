Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWHDU50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWHDU50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161442AbWHDU50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:57:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:41690 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161441AbWHDU5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:57:25 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [RFC][PATCH] A generic boolean
To: Jes Sorensen <jes@sgi.com>, Andreas Schwab <schwab@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 04 Aug 2006 22:51:15 +0200
References: <6AqZX-3dU-29@gated-at.bofh.it> <6Art3-45j-35@gated-at.bofh.it> <6G8xj-W7-13@gated-at.bofh.it> <6G8QL-1lI-35@gated-at.bofh.it> <6G90s-1yo-55@gated-at.bofh.it> <6G9Wm-30t-3@gated-at.bofh.it> <6GafR-3o1-13@gated-at.bofh.it> <6Gapq-3OH-15@gated-at.bofh.it> <6Gapq-3OH-13@gated-at.bofh.it> <6Gaz6-40T-21@gated-at.bofh.it> <6GaIN-4dw-25@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G96ds-0000ht-HT@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> wrote:
> Andreas Schwab wrote:

>> Try determining the alignment of u64 on i386.  You will be surprised.
> 
> If thats the case, then thats really scary :-( I'd claim it's a bug and
> I am willing to be that iptables isn't the only place that is affected
> or will be in the future.

It's not a bug, since 64 bit integers require only 4-byte-alignment if
addressed by the CPU/FPU. You may benefit from cacheline effects if you
align to 64 bits, but not on i[34]86 (and those define the ABI).

If you want 64-bit-alignment, you can use -malign-double.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
