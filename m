Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSBSBpL>; Mon, 18 Feb 2002 20:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289234AbSBSBow>; Mon, 18 Feb 2002 20:44:52 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:12859 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S289236AbSBSBou>; Mon, 18 Feb 2002 20:44:50 -0500
Message-ID: <092401c1b8e7$1d190660$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Ben Collins" <bcollins@debian.org>
Subject: readl/writel and memory barriers
Date: Mon, 18 Feb 2002 20:45:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are the PCI memory access functions like readl() and writel() supposed to
enforce ordering without explicit memory barriers?

I've heard inconsistent reports - Benjamin Herrenschmidt pointed out that on
PPC, the definitions of readl() and writel() include memory barriers. But
the code example on page 229 of Rubini and Corbet's "Linux Device Drivers"
2nd ed. suggests that an explicit wmb() is needed to preserve ordering of
writel()s.

In a quick survey of architectures that need explicit memory barriers to
enforce ordering of PCI accesses, it seems that alpha and PPC include memory
barriers inside readl() and writel(), whereas MIPS, sparc64, ia64, and s390
do not include them. (I'm not intimately familiar with these architectures
so forgive me if I got some wrong...). What is the official story here?

Regards,
Dan

