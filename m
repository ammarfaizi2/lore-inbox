Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136552AbRASBLl>; Thu, 18 Jan 2001 20:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136556AbRASBLb>; Thu, 18 Jan 2001 20:11:31 -0500
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:44046 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S136552AbRASBLR>;
	Thu, 18 Jan 2001 20:11:17 -0500
Message-ID: <3A679432.8060609@signalstorm.com>
Date: Fri, 19 Jan 2001 01:11:14 +0000
From: Steven Ellmore <steve@signalstorm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: typo in buffer_busy macro in fs/buffer.c ??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This looks like a typo:
(line 2341 of fs/buffer.c in unpatched 2.4.0
line 2345 of fs/buffer.c in 2.4.1-pre8)

#define buffer_busy(bh) (atomic_read(&(bh)->b_count) | ((bh)->b_state &
BUFFER_BUSY_BITS))

surely, it should be:
#define buffer_busy(bh) (atomic_read(&(bh)->b_count) || ((bh)->b_state &
BUFFER_BUSY_BITS))

i.e. logical OR instead of bitwise.

Shouldn't it?


-Steve Ellmore



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
