Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUBRLnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUBRLnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:43:55 -0500
Received: from dp.samba.org ([66.70.73.150]:48296 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266222AbUBRLnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:43:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.20457.610841.62521@samba.org>
Date: Wed, 18 Feb 2004 22:43:37 +1100
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: hpa@zytor.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <200402181105.58425.robin.rosenberg.lists@dewire.com>
References: <16434.58656.381712.241116@samba.org>
	<200402181105.58425.robin.rosenberg.lists@dewire.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin,

 > I've read it also:
 > http://www.microsoft.com/globaldev/getwr/steps/wrg_unicode.mspx
 > "The fundamental representation of text in Windows NT-based
 > operating systems is UTF-16"

yep, in this thread I've been mistakenly using the term UCS-16 when I
should have said UTF-16 (ie. the variable length, 2 byte encoding).

Samba currently treats the bytes on the wire from windows as UCS-2 (a
2 byte fixed width encoding), whereas perhaps it should be treating
them as UTF-16. I should write a smbtorture test to detect the
difference and see what different versions of windows actually use.

luckily the new charset handling stuff in samba3 and samba4 will make
this easy to fix :-)
