Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267915AbTBRTNm>; Tue, 18 Feb 2003 14:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267929AbTBRTNm>; Tue, 18 Feb 2003 14:13:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267915AbTBRTNm>;
	Tue, 18 Feb 2003 14:13:42 -0500
Subject: CIFS (2.5.62) build problems
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045596223.17584.139.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Feb 2003 11:23:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CIFS can not be built as a module because it cifs_readpages calls:
 __pagevec_lru_add
 add_to_page_cache

The patch to mm/filemap.c and mm/swap.c is trivial, the question is
should those internal functions be exported in the first place.

-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab

