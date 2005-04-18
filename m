Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVDRK76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVDRK76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 06:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVDRK76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 06:59:58 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:18347 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262031AbVDRK74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 06:59:56 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>,
       Davide Libenzi <davidel@xmailserver.org>,
       Daniel Jacobowitz <dan@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 18 Apr 2005 12:59:17 +0200
References: <3Uv7B-5lv-7@gated-at.bofh.it> <3UvKd-5RT-1@gated-at.bofh.it> <3Uw3y-65a-1@gated-at.bofh.it> <3UwmX-6gm-5@gated-at.bofh.it> <3UwwG-6lY-7@gated-at.bofh.it> <3UwGk-6Cv-9@gated-at.bofh.it> <3Uxj2-6YL-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DNTyI-0000pu-HQ@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp> wrote:

> systr_pmem_read() and systr_pmem_write() just calls ptrace
> PTRACE_PEEKTEXT/DATA repeatedly.... In this case we need to *stop* target
> process whenever patch modules is loading....

You'll have to do that anyway, since you'll need to atomically store two
machine words. At least you'll have to lock access to the corresponding
memory page(s).
-- 
Error, no keyboard -- press F1 to continue. 

Friﬂ, Spammer: 6pr@pPQ.7eggert.dyndns.org root@qe23.biz
 antisemitic@7frying.com Harvardizes@rewardsrx.com Mavis@miedcbbj.info
