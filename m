Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276467AbRI2JIp>; Sat, 29 Sep 2001 05:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276466AbRI2JIf>; Sat, 29 Sep 2001 05:08:35 -0400
Received: from colorfullife.com ([216.156.138.34]:16905 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S276467AbRI2JI0>;
	Sat, 29 Sep 2001 05:08:26 -0400
Message-ID: <3BB58FAF.D1AF2D25@colorfullife.com>
Date: Sat, 29 Sep 2001 11:09:03 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lock_kiovec question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lock_kiovec tries to lock each page in the kiovec, and fails if it can't
lock one of the pages.

What if the zero page is mapped multiple times in the kiobuf?

AFAICS map_user_pages doesn't break zero page mappings if it's called
with rw==WRITE (i.e write to disk, read from kiobuf)

--
	Manfred
