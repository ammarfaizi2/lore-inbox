Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264279AbRGBMpL>; Mon, 2 Jul 2001 08:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264893AbRGBMpB>; Mon, 2 Jul 2001 08:45:01 -0400
Received: from real.realitydiluted.com ([208.242.241.164]:24842 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id <S264279AbRGBMop>; Mon, 2 Jul 2001 08:44:45 -0400
Message-ID: <3B406B63.4E28CA8A@cotw.com>
Date: Mon, 02 Jul 2001 07:38:59 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: dwmw2@redhat.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: linux-2.4.6-pre8/drivers/mtd/nand/spia.c: undefined symbols
In-Reply-To: <200107012207.PAA01921@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         linux-2.4.6-pre8/drivers/mtd/nand/spia.c references four
> undefined symbols, presumably intended to be #define constants,
> although I am not sure what their values are supposed to be:
> 
>         IO_BASE
>         FIO_BASE
>         PEDR
>         PEDDR
> 
The way that I architected the raw NAND flash device driver was to
break it into 2 parts. 'nand.c' contains the actual driver code and
is considered to be device independent. 'spia.c' is the device
dependent part. You should write your own version of 'spia.c' and
"simply" fill in the addresses for the IO address and control
register address depending on your specific hardware. The above
symbols are only defined for my specific hardware. They should be
changed to values used on your hardware platform. Let me know if
you need further assistance.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
