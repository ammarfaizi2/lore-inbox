Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWAOP2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWAOP2J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 10:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWAOP2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 10:28:08 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:36567 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932075AbWAOP2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 10:28:07 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
To: Andrew Morton <akpm@osdl.org>, "Bryan O'Sullivan" <bos@pathscale.com>,
       hch@infradead.org, rdreier@cisco.com, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 15 Jan 2006 16:33:51 +0100
References: <5s6p8-1O3-29@gated-at.bofh.it> <5s6p8-1O3-27@gated-at.bofh.it> <5tnZx-1lb-17@gated-at.bofh.it> <5tt8U-xV-5@gated-at.bofh.it> <5tueu-2mb-9@gated-at.bofh.it> <5tvaH-3MA-55@gated-at.bofh.it> <5tvX6-4MO-13@gated-at.bofh.it> <5tvX6-4MO-11@gated-at.bofh.it> <5tvXa-4MO-23@gated-at.bofh.it> <5tzQR-2zH-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Ey9tA-0000sB-6f@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> One option is to just stick the thing in an existing lib/ or kernel/ file
> and mark it __attribute__((weak)).  That way architectures can override it
> for free with no ifdefs, no Makefile trickery, no Kconfig trickery, etc.

What about "#define funcname funcname" in arch-specific headers iff it's
redefined, and protecting the definition in the generic file by "#ifndef
funcname"?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
