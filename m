Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbSIXVE5>; Tue, 24 Sep 2002 17:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261814AbSIXVE5>; Tue, 24 Sep 2002 17:04:57 -0400
Received: from ns.splentec.com ([209.47.35.194]:48907 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S261813AbSIXVE4>;
	Tue, 24 Sep 2002 17:04:56 -0400
Message-ID: <3D90D4AB.B0BDF702@splentec.com>
Date: Tue, 24 Sep 2002 17:10:03 -0400
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: struct page question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to build a struct page *page, where
page_address(page) == some virtual address (not high mem of course)?

The reason I want to do this is so that I can pass it to
generic_make_request(), having only a pointer to a buffer
and size to a buffer, and the fact that not all devices
have request_fn() exposed (e.g. md).

Apparently I cannot just set b_data and b_size, b_page
also has to be set and it also seems that it will
not work if page_address(b_page) != b_data...

Thanks,
-- 
Luben
