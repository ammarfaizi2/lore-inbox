Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318307AbSGRTMP>; Thu, 18 Jul 2002 15:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSGRTMP>; Thu, 18 Jul 2002 15:12:15 -0400
Received: from pc1-alde1-3-cust222.gfd.cable.ntl.com ([62.252.20.222]:31322
	"EHLO mayday.local") by vger.kernel.org with ESMTP
	id <S318307AbSGRTMO>; Thu, 18 Jul 2002 15:12:14 -0400
Date: Thu, 18 Jul 2002 20:15:05 +0100 (BST)
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
In-Reply-To: <20020702173636.A13790@pegasys.ws>
Organization: Mayday Technology Ltd
X-URL: <http://www.cix.co.uk/~mayday>
X-Dev86-Version: 0.16.2
Reply-By: 01 jan 1900 00:00:00
X-Message-Flag: Linux: The choice of a GNU generation.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Robert de Bath <robert$@mayday.cix.co.uk>
Message-ID: <8ff9ed84695e27db@mayday.cix.co.uk>
X-Mailer: Pine for Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, jw schultz wrote:

> wouldn't add too much more overhead than
>
> 	if (!emulation_notice)
> 	{
> 		emulation_notice = 1;
> 		printk(...);
> 	}
>
> after all this is only supposed to happen under rescue
> situations.  That way it will be sure to be in the logs and
> maybe even on the console and we won't have to hunt for it.
>
> Also, the message should say you are doing instruction
> emulation.  "wrong model cpu, emulating instruction XXX" I
> doubt indicating the program is helpful unless the tracking
> is done per task or the printk every time you emulate.

I'd suggest this message could be so frequent that you want to
link it's display to real time. Check the jiffy counter each
time and if it's been less that X seconds since the last message
just up a counter. Plus in the message say how many instructions
have been emulated since the last one ... eg if it's only five
I don't care, but five million would be a problem!

One other thing ... should the FPU emulator also display messages
like these if it's used?

-- 
Rob.                          (Robert de Bath <robert$ @ debath.co.uk>)
                                       <http://www.cix.co.uk/~mayday>


