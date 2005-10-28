Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVJ1WS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVJ1WS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVJ1WS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:18:28 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:6349 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750702AbVJ1WS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:18:27 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
To: Pavel Machek <pavel@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
       vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 29 Oct 2005 00:18:18 +0200
References: <52bjf-680-9@gated-at.bofh.it> <52Hj9-3e6-27@gated-at.bofh.it> <52HCr-3CO-7@gated-at.bofh.it> <52JkU-6gS-29@gated-at.bofh.it> <52JuY-6s7-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EVcYE-00016V-Dg@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:

> Well, keyboard detected and reported an error. Kernel reacted with
> printk(). You are removing that printk(). I can understand that,
> printk is really annoying, but I really believe _some_ error handling
> should be added there if you remove the printk.

I once posted a printk that would only actually print if the last printk
wasn't the same message. This would ensure error reporting while preventing
dmesg from being spammed. Off cause this would fail if two subsystems are
competing to annoy you.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
