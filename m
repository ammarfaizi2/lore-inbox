Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264887AbSKEQYe>; Tue, 5 Nov 2002 11:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSKEQYd>; Tue, 5 Nov 2002 11:24:33 -0500
Received: from ulima.unil.ch ([130.223.144.143]:34951 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264887AbSKEQYb>;
	Tue, 5 Nov 2002 11:24:31 -0500
Date: Tue, 5 Nov 2002 17:31:06 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Cc: linux-dvb@linuxtv.org
Subject: 2.5.46: DVB don't work...
Message-ID: <20021105163106.GA5169@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

from dmesg:

Unable to handle kernel paging request at virtual address e2cd9f4a
 printing eip:
e2cd9f4a
*pde = 1713a067
*pte = 00000000
Oops: 0000
floppy alps_bsrv2 eepro100 mii ehci-hcd usbcore  
CPU:    0
EIP:    0060:[<e2cd9f4a>]    Not tainted
EFLAGS: 00010206
EIP is at E __insmod_alps_bsrv2_S.data_L342+0x2b4a/0x158 [alps_bsrv2]
eax: d555ff6c   ebx: d6e3a100   ecx: d7db83b0   edx: d6e3a100
esi: d555ffdc   edi: 80046f45   ebp: d555ffdc   esp: d555ff58
ds: 0068   es: 0068   ss: 0068
Process kdvb-fe (pid: 1084, threadinfo=d555e000 task=d779cd80)
Stack: e2cd6162 d6e3a100 d555ff6c 00000002 0e000054 00000008 00000002 d555ff6a 
       00010008 00000001 d555ff69 0000001f d555e000 e2cd693f d6e3a100 0000000e 
       d779cd80 ffffffa1 d7db8204 c0262267 d7db8204 80046f45 d555ffdc d7db8200 
Call Trace:
 [<e2cd6162>] ves1893_readreg+0x68/0x9a [alps_bsrv2]
 [<e2cd693f>] bsrv2_ioctl+0x181/0x344 [alps_bsrv2]
 [<c0262267>] dvb_frontend_internal_ioctl+0x5b/0xa0
 [<c0262c54>] dvb_frontend_thread+0x12e/0x250
 [<c0262b26>] dvb_frontend_thread+0x0/0x250
 [<c01070c1>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 0000ae18
 printing eip:
e2cdfd88
*pde = 00000000
Oops: 0000
dvb-ttpci floppy alps_bsrv2 eepro100 mii ehci-hcd usbcore  
CPU:    0
EIP:    0060:[<e2cdfd88>]    Not tainted
EFLAGS: 00010246
EIP is at outcom+0x56/0xd4 [dvb-ttpci]
eax: 00000000   ebx: d61e5ec0   ecx: d61e5f00   edx: 00000001
esi: 00000001   edi: 00000003   ebp: d61e5ee4   esp: d61e5eb0
ds: 0068   es: 0068   ss: 0068
Process insmod (pid: 2026, threadinfo=d61e4000 task=d7db0080)
Stack: c15bb450 c15bb460 c022b313 00000246 0001010b c0490001 e2d2b180 00000000 
       d61e4000 d61e5ec8 00000000 00000000 00000000 e2cd9000 e2cde65c 00000000 
       00000001 0000000b 00000001 00000001 e2ce7590 00000000 00000001 00000001 
Call Trace:
 [<c022b313>] driver_attach+0x49/0x7e
 [<e2d2b180>] input_dev+0x0/0x638 [dvb-ttpci]
 [<e2cde65c>] av7110_setup_irc_config+0x38/0x44 [dvb-ttpci]
 [<e2ce7590>] av7110_ir_init+0x52/0x9c [dvb-ttpci]
 [<e2cdad7b>] saa7146_init_module+0x49/0x78 [dvb-ttpci]
 [<e2cec280>] saa7146_driver+0x0/0xa0 [dvb-ttpci]
 [<c011e495>] sys_init_module+0x4eb/0x62e
 [<e2cd9060>] i2c_status_check+0x0/0x3a [dvb-ttpci]
 [<e2cd9060>] i2c_status_check+0x0/0x3a [dvb-ttpci]
 [<c0108f93>] syscall_call+0x7/0xb

Code: 8b 80 18 ae 00 00 85 c0 75 12 ba ff ff ff ff 8b 65 f0 89 d0 

It was perfectly working under 2.5.45...

Thank you, 

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
