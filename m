Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315810AbSEJFLt>; Fri, 10 May 2002 01:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315811AbSEJFLs>; Fri, 10 May 2002 01:11:48 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:14334 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315810AbSEJFLs>;
	Fri, 10 May 2002 01:11:48 -0400
To: linux-kernel@vger.kernel.org
Subject: maximum block size in buffer_head
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Message-Id: <E1762h0-00086K-00@wailua.hpl.hp.com>
From: David Mosberger <davidm@napali.hpl.hp.com>
Date: Thu, 09 May 2002 22:11:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current Linux kernel (both 2.4.xx and 2.5.xx) declare the b_size
member in struct buffer_head as an "unsigned short".  This obviously
limits the maximum block size to something less than 65536.  This is
bad because on some platforms (e.g., ia64), the page size can be up to
64KB large.

Two questions:

 - does anyone object to widening b_size to "unsigned int"?

 - does anyone know of any other code paths where the block
   size is assumed to fit into 16 bits?

Thanks,

	--david
