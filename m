Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSHKXbx>; Sun, 11 Aug 2002 19:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318464AbSHKXbx>; Sun, 11 Aug 2002 19:31:53 -0400
Received: from web40305.mail.yahoo.com ([66.218.78.84]:28254 "HELO
	web40305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318460AbSHKXbx>; Sun, 11 Aug 2002 19:31:53 -0400
Message-ID: <20020811233536.62979.qmail@web40305.mail.yahoo.com>
Date: Sun, 11 Aug 2002 16:35:36 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: kernel BUG at page_alloc.c
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am getting kernel BUG when i deal with big files :-

kernel BUG at page_alloc.c:203!

I am using 2.4.1 on SH4 and using only 32 MB RAM
without hard-disk, so only thing i am using is 32 MB
RAM .


/* page_alloc.c */
if (BAD_RANGE(zone,page))
	BUG();
DEBUG_ADD_PAGE    <--- line no 203


/* linux/swap.h */

#define DEBUG_ADD_PAGE \
	if (PageActive(page) || PageInactiveDirty(page) || \
	PageInactiveClean(page)) BUG();


Can someone please guide me and let me know the
work-around for this kernel BUG.

Thanks for your help.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
