Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314862AbSD2IHB>; Mon, 29 Apr 2002 04:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314865AbSD2IHA>; Mon, 29 Apr 2002 04:07:00 -0400
Received: from vp170156.nte.uac1.hknet.com ([203.169.170.156]:53513 "EHLO
	kingdom.homelan") by vger.kernel.org with ESMTP id <S314862AbSD2IHA>;
	Mon, 29 Apr 2002 04:07:00 -0400
Message-ID: <006d01c1ef54$d35f8b30$0100a8c0@client>
From: "Wong Tsang" <kernel@kingdom-lan.net>
To: <linux-kernel@vger.kernel.org>
Subject: Free pages after brw_page() in buffer.c
Date: Mon, 29 Apr 2002 16:06:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

                I dun know whether it is appropriate to ask question here. But
I have seeked for help in many places and got no replies. :(
Pls forgive me if I have done something wrong.

                I have written a driver to do some I/O using brw_page(). I first
use __get_free_pages() to get some free pages and then pass them to brw_page()
to issue the I/O requests. Afterwards, I find that I have difficulties to free the
allocated pages by simply using free_pages().Because the page->count
becomes 2 (increment once in __get_free_pages() and increment once
in brw_page() ) and page->buffers is not NULL.

                So what is the appropriate way to decrement the page count made
by brw_page and free those buffers in page->buffers? or more specifically, 
how can I free the pages which have been used in brw_page()? 

                After reading buffer.c, I guess try_to_free_buffers() may work but
I fear it is not the appropriate and may leave some hidden problems afterwards.

                Thx in advance!

Wong Tsang


