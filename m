Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313864AbSDPUBE>; Tue, 16 Apr 2002 16:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313865AbSDPUBE>; Tue, 16 Apr 2002 16:01:04 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:34209 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S313864AbSDPUBC>;
	Tue, 16 Apr 2002 16:01:02 -0400
Message-ID: <3CBC8281.5A2BEDA3@hp.com>
Date: Tue, 16 Apr 2002 13:58:57 -0600
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7, ppp problem
In-Reply-To: <3CBC7D8E.5CC95F13@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try the following patch and see if it works:

--
Khalid

--- linux-2.4.18-hcdpold/include/asm-i386/serial.h      Tue Apr 16
12:05:27 2002
+++ linux-2.4.18-hcdp/include/asm-i386/serial.h Tue Apr 16 12:02:54 2002
@@ -140,8 +140,8 @@
 #endif
 
 #define SERIAL_PORT_DFNS               \
-       HCDP_SERIAL_PORT_DEFNS          \
        STD_SERIAL_PORT_DEFNS           \
+       HCDP_SERIAL_PORT_DEFNS          \
        EXTRA_SERIAL_PORT_DEFNS         \
        HUB6_SERIAL_PORT_DFNS           \
        MCA_SERIAL_PORT_DFNS


Jean-Luc Coulon wrote:
> 
> Hi,
> 
> I have a serial modem and I use ppp to connect my isp.
> With 2.4.19-pre7 it does not works. Nothing happens after loading the
> ppp module.
> All is fine with pre5 and pre6
> 
> ----
> Regards

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
