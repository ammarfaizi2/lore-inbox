Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313332AbSDLPyQ>; Fri, 12 Apr 2002 11:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314103AbSDLPyP>; Fri, 12 Apr 2002 11:54:15 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:21266 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S313332AbSDLPyO>; Fri, 12 Apr 2002 11:54:14 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A777B@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Guennadi Liakhovetski'" <gl@dsa-ac.de>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: serial driver question
Date: Fri, 12 Apr 2002 08:54:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Hello all
> 
> The function
> static int size_fifo(struct async_struct *info)
> {
> ...
> ends as follows:
> 	serial_outp(info, UART_LCR, UART_LCR_DLAB);
> 	serial_outp(info, UART_DLL, old_dll);
> 	serial_outp(info, UART_DLM, old_dlm);
> 
> 	return count;
> }
> 
> Which means, that DLAB is not re-set, and, in particular, all 
> subsequent read/write operations on offsets 0 and 1 will not 
> affect the data and interrupt enable registers, but the divisor 
> latch register... Or is this register somehow magically restored 
> elsewhere or by the hardware (say, on an interrupt)? This 
> function seems to be only called for startech UARTs.

Hi Guennadi,

I'll look at it as soon as my system is up. It's morning boot-up time here.
Have a good evening.

Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

