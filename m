Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTA1CwU>; Mon, 27 Jan 2003 21:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbTA1CwU>; Mon, 27 Jan 2003 21:52:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65038 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267319AbTA1CwT>;
	Mon, 27 Jan 2003 21:52:19 -0500
Message-ID: <3E35F221.8050606@pobox.com>
Date: Mon, 27 Jan 2003 21:59:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Fu, Michael" <michael.fu@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] e100 driver fails to initialize the hardware after ker
 nel bootup through kexec
References: <957BD1C2BF3CD411B6C500A0C944CA2602E947F0@pdsmsx32.pd.intel.com>
In-Reply-To: <957BD1C2BF3CD411B6C500A0C944CA2602E947F0@pdsmsx32.pd.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fu, Michael wrote:
> On Sat, 2003-01-25 at 00:07, Jeff Garzik wrote:
> On Fri, Jan 24, 2003 at 05:57:55PM +0300, Andrey Nekrasov wrote:
> 
>>>or "e100" driver and with patch:
>>>
>>>
>>>--- drivers/net/e100/e100.h-    Wed Dec  4 15:16:08 2002 
>>>+++ drivers/net/e100/e100.h     Wed Dec  4 15:16:20 2002 
>>>@@ -100,7 +100,7 @@
>>> 
>>> #define E100_MAX_NIC 16
>>> 
>>>-#define E100_MAX_SCB_WAIT      100     /* Max udelays in wait_scb */ 
>>>+#define E100_MAX_SCB_WAIT      5000    /* Max udelays in wait_scb */ 
>>> #define E100_MAX_CU_IDLE_WAIT  50      /* Max udelays in wait_cus_idle

> Which release your patch applies for ? I failed to compile it on 2.5.52. It
> seems that function e100_disable_clear_intr is not defined.


This wasn't my patch :)   But anyway, 2.4.x series is actually ahead of
2.5.x in terms of e100 bugfixes, owing to Linus's vacation.  If you use
 BitKeeper, you can obtain the latest by issuing
	bk pull http://linux.bkbits.net/linux-2.4

or wait another day or so for Marcelo to release 2.4.21-pre4 :)

The 2.5 and 2.4 versions of e100 are kept in sync, so it is trivial to
take 2.4's e100 and use it in 2.5 [and vice versa].

	Jeff



