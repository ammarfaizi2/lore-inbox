Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSKYOY4>; Mon, 25 Nov 2002 09:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSKYOY4>; Mon, 25 Nov 2002 09:24:56 -0500
Received: from [193.130.228.132] ([193.130.228.132]:32007 "HELO
	mailessentials.london.csf.co.uk") by vger.kernel.org with SMTP
	id <S263333AbSKYOYz>; Mon, 25 Nov 2002 09:24:55 -0500
Message-ID: <C3521D5A224C344284C3666E831BF68021B057@london_exch2>
From: mark.hodge@xaman.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.49 Compilation error
Date: Mon, 25 Nov 2002 14:31:50 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When "CONFIG_INPUT=m" the 2.5.49 kernel falies to compile with

drivers/built-in.o: In function `kd_nosound':
drivers/built-in.o(.text+0x13140): undefined reference to `input_event'
drivers/built-in.o(.text+0x1315d): undefined reference to `input_event'
drivers/built-in.o: In function `kd_mksound':
drivers/built-in.o(.text+0x1320a): undefined reference to `input_event'
drivers/built-in.o: In function `kbd_bh':
drivers/built-in.o(.text+0x1409a): undefined reference to `input_event'
drivers/built-in.o(.text+0x140a8): undefined reference to `input_event'
drivers/built-in.o(.text+0x140b9): more undefined references to
`input_event' follow
drivers/built-in.o: In function `kbd_connect':
drivers/built-in.o(.text+0x1454e): undefined reference to
`input_open_device'
drivers/built-in.o: In function `kbd_disconnect':
drivers/built-in.o(.text+0x14567): undefined reference to
`input_close_device'
drivers/built-in.o: In function `kbd_init':
drivers/built-in.o(.init.text+0xdbe): undefined reference to
`input_register_handler'

when "CONFIG_INPUT=y" compilation works fine, diff on working and faulty
.config file
--
952c952
< CONFIG_INPUT=y
---
> CONFIG_INPUT=m
981c981
< CONFIG_KEYBOARD_ATKBD=y
---
> CONFIG_KEYBOARD_ATKBD=m
986c986
< CONFIG_MOUSE_PS2=y
---
> CONFIG_MOUSE_PS2=m



Mark J Hodge					    mark.hodge@xaman.com
Senior Technical Consultant			 Tel: +44 (0)870 7499739
Xaman plc						 Fax: +44 (0)870
7499290


This e-mail including any attachments is confidential and may be 
legally privileged. If you have received it in error please advise the
sender immediately by return email and then delete it from your 
system. 
All electronic communications with the Company may be monitored
in accordance with the UK Regulation of Investigatory Powers Act,
Lawful Business Practice Regulations, 2000. 
If you do not consent to such monitoring, you should contact 
the sender of the e-mail.
The unauthorised use, distribution, copying or alteration of this 
email is strictly forbidden. If you need assistance please contact 
Head Office on (+44)(0)870 749 9000 between 9:00 am and 5:30 pm GMT
