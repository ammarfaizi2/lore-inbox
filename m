Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRHMTnG>; Mon, 13 Aug 2001 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRHMTmq>; Mon, 13 Aug 2001 15:42:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10624 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264797AbRHMTmk>;
	Mon, 13 Aug 2001 15:42:40 -0400
Date: Mon, 13 Aug 2001 12:42:26 -0700 (PDT)
Message-Id: <20010813.124226.92585606.davem@redhat.com>
To: groudier@free.fr
Cc: alan@lxorguk.ukuu.org.uk, sandy@storm.ca, linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010813205023.P806-100000@gerard>
In-Reply-To: <20010813.072157.71088670.davem@redhat.com>
	<20010813205023.P806-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id FAA11778

   From: Gérard Roudier <groudier@free.fr>
   Date: Mon, 13 Aug 2001 21:07:50 +0200 (CEST)

   That's the major problem if we ever want to preserve some ordering in the
   queuing of SCSI IOs.

When DMA mapping operation fails, you simply "stop queueing".  Queue
freezes and nothing new is executed.

DMA wakeup makes you start where you left off.  I cannot see any
ordering constraints violated by this as a side effect.  It is like a
"cork" for running scsi commands in the driver.

The purpose of the hypothetical kernel thread is to get out
of interrupt context if that is deemed necessary.

It may not be.

Later,
David S. Miller
davem@redhat.com
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
