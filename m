Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262644AbSI0XlU>; Fri, 27 Sep 2002 19:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262645AbSI0XlU>; Fri, 27 Sep 2002 19:41:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:34529 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262644AbSI0XlU>;
	Fri, 27 Sep 2002 19:41:20 -0400
Message-ID: <3D94ED88.5040407@us.ibm.com>
Date: Fri, 27 Sep 2002 16:45:12 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: sysrq on serial console 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the serial cleanups happened in 2.5, Magic Sysrq doesn't work 
for me on the serial console.

It looks like the UART_LSR_BI bit needs to be set in the status 
variable for the break character to be interpreted as a break in the 
driver.

I doubt that it is actually broken,  but it isn't immediately obvious 
how that bit gets set.  Is there something that I should have set when 
the device was initialized to make sure that UART_LSR_BI is asserted 
in "status" when the interrupt occurs?

-- 
Dave Hansen
haveblue@us.ibm.com

