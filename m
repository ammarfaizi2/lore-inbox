Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVCLPvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVCLPvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVCLPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:51:46 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:42257 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261937AbVCLPvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:51:43 -0500
To: Junfeng Yang <yjf@stanford.edu>
Cc: chaffee@bmrc.berkeley.edu, mc@cs.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] sync doesn't flush everything out (msdos and vfat,
 2.6.11)
References: <Pine.GSO.4.44.0503120230540.10944-100000@elaine24.Stanford.EDU>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Mar 2005 00:51:28 +0900
In-Reply-To: <Pine.GSO.4.44.0503120230540.10944-100000@elaine24.Stanford.EDU> (Junfeng
 Yang's message of "Sat, 12 Mar 2005 02:36:10 -0800 (PST)")
Message-ID: <878y4sg8vz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> writes:

> Test cases and crashed disk images can be found at
> http://fisc.stanford.edu/bug8    (msdos)
> http://fisc.stanford.edu/bug11   (vfat)

vfat and msdos doesn't support the link(), and the truncate() which
extends size is not supported yet.

This test seems to calling abort(0) by CHECK(ret)...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
