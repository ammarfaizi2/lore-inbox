Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSHZXxt>; Mon, 26 Aug 2002 19:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSHZXxt>; Mon, 26 Aug 2002 19:53:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50829 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310190AbSHZXxs>;
	Mon, 26 Aug 2002 19:53:48 -0400
Message-ID: <3D6AC075.8060007@us.ibm.com>
Date: Mon, 26 Aug 2002 16:57:41 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Lack of Input-Core causes link errors
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current bk tree won't compile without initcore compiled in.  Adding it 
makes the link errors go away.  I saw a comment in Linus's changelog about 
this, is there a fix in progress?

drivers/built-in.o: In function `kd_nosound':
drivers/built-in.o(.text+0x1603f): undefined reference to `input_event'
drivers/built-in.o(.text+0x16058): undefined reference to `input_event'
drivers/built-in.o: In function `kd_mksound':
drivers/built-in.o(.text+0x160e7): undefined reference to `input_event'
drivers/built-in.o: In function `kbd_bh':
drivers/built-in.o(.text+0x16cca): undefined reference to `input_event'
drivers/built-in.o(.text+0x16cd8): undefined reference to `input_event'
drivers/built-in.o(.text+0x16ce9): more undefined references to 
`input_event' follow
drivers/built-in.o: In function `kbd_connect':
drivers/built-in.o(.text+0x170e3): undefined reference to `input_open_device'
drivers/built-in.o: In function `kbd_disconnect':
drivers/built-in.o(.text+0x170ff): undefined reference to `input_close_device'
drivers/built-in.o: In function `kbd_init':
drivers/built-in.o(.text.init+0x1c57): undefined reference to 
`input_register_handler'

-- 
Dave Hansen
haveblue@us.ibm.com

