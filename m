Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTAPTw3>; Thu, 16 Jan 2003 14:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbTAPTw3>; Thu, 16 Jan 2003 14:52:29 -0500
Received: from adsl-109-100.gigavia.com.ar ([200.26.109.100]:26530 "EHLO
	morgoth.srv.sis.cooperativaobrera.com.ar") by vger.kernel.org
	with ESMTP id <S267243AbTAPTw2>; Thu, 16 Jan 2003 14:52:28 -0500
Message-ID: <3E270F58.9020609@bblanca.com.ar>
Date: Thu, 16 Jan 2003 17:00:24 -0300
From: Gabriel Gomiz <gomita@bblanca.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: NCR 7452/3 POS - Retail CMOS NVRAM Driver
References: <Pine.LNX.3.95.1030116080150.3536A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030116080150.3536A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 15 Jan 2003, Gabriel Gomiz wrote:
>>
>>The memory chips that NCR uses are:
>>1) NEC D43256BGU - NCR POS Model 7452-1011
>>    The chip is 256KB, but NCR says they use only 128KB
>>2) NEC D431000AGW - NCR POS Model 7453-1011
>>    The chip is 1MB, but NCR says they use only 128KB
>>
> 
> Look in the ethernet drivers for the "bit-banging" routines
> used to access NVRAM in the devices. You need to shift bits
> in and out of these devices. They are SERIAL ERPROMS. You
> can get data sheets by using your favorite search engine
> (as I just did).

I grabbed the datasheets of the memory chips and found out the 
following, that changes the incorrect information that I had:

1) NEC D43256BGU is 256Kbits = 32KB (32768 words of 8 bits)

This chip has 15 address lines (A0-A14) and 8 data lines (I/O1 - I/O8).

2) NEC D431000AGW is 1Mbit = 128KB (131072 word of 8 bits)

This chip has 17 address lines (A0-A16) and 8 data lines (I/O1 - I/O8).

So it seems that these chips doesn't have a serial-like interface for 
bit-banging, I am wrong?

-- 
    .^.    Gabriel Gomiz - Red Hat Certified Engineer (RHCE)
    /V\
   // \\
  /(   )\
   ^^-^^   s/Window[$s]/LINUX!!/g or die;

