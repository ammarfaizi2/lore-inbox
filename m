Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSHZXz6>; Mon, 26 Aug 2002 19:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318289AbSHZXz6>; Mon, 26 Aug 2002 19:55:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:60546 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S311749AbSHZXz5>;
	Mon, 26 Aug 2002 19:55:57 -0400
Date: Tue, 27 Aug 2002 01:59:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Lack of Input-Core causes link errors
Message-ID: <20020827015957.A26996@ucw.cz>
References: <3D6AC075.8060007@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D6AC075.8060007@us.ibm.com>; from haveblue@us.ibm.com on Mon, Aug 26, 2002 at 04:57:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 04:57:41PM -0700, Dave Hansen wrote:
> Current bk tree won't compile without initcore compiled in.  Adding it 
> makes the link errors go away.  I saw a comment in Linus's changelog about 
> this, is there a fix in progress?
> 
> drivers/built-in.o: In function `kd_nosound':
> drivers/built-in.o(.text+0x1603f): undefined reference to `input_event'
> drivers/built-in.o(.text+0x16058): undefined reference to `input_event'
> drivers/built-in.o: In function `kd_mksound':
> drivers/built-in.o(.text+0x160e7): undefined reference to `input_event'
> drivers/built-in.o: In function `kbd_bh':
> drivers/built-in.o(.text+0x16cca): undefined reference to `input_event'
> drivers/built-in.o(.text+0x16cd8): undefined reference to `input_event'
> drivers/built-in.o(.text+0x16ce9): more undefined references to 
> `input_event' follow
> drivers/built-in.o: In function `kbd_connect':
> drivers/built-in.o(.text+0x170e3): undefined reference to `input_open_device'
> drivers/built-in.o: In function `kbd_disconnect':
> drivers/built-in.o(.text+0x170ff): undefined reference to `input_close_device'
> drivers/built-in.o: In function `kbd_init':
> drivers/built-in.o(.text.init+0x1c57): undefined reference to 
> `input_register_handler'

Yes. Input core will always be built in. (Linus's choice out of other
possible.)

-- 
Vojtech Pavlik
SuSE Labs
