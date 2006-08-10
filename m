Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161197AbWHJMBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWHJMBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbWHJMBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:01:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:8153 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161196AbWHJMBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:01:43 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [KJ] [patch] fix common mistake in polling loops
To: Darren Jenkins <darrenrjenkins@gmail.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       "Om N." <xhandle@gmail.com>, kernel-janitors@osdl.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 10 Aug 2006 13:58:10 +0200
References: <6DvTu-6tk-17@gated-at.bofh.it> <6Ho72-7do-3@gated-at.bofh.it> <6HpZd-1vB-19@gated-at.bofh.it> <6I6B4-72S-7@gated-at.bofh.it> <6I7np-8bD-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GB9BH-0000hE-9m@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Jenkins <darrenrjenkins@gmail.com> wrote:

> The only Nitpick is
> 
> - int timeup = 0;
> + unsigned char timeup = 0;

Using ints is usurally cheaper than using chars, especially if the
compiler can use a register. YMMV, and may the .s be with you.-)
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
