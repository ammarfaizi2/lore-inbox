Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSGNMOm>; Sun, 14 Jul 2002 08:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSGNMOl>; Sun, 14 Jul 2002 08:14:41 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:22421 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S316051AbSGNMOk>;
	Sun, 14 Jul 2002 08:14:40 -0400
Date: Sun, 14 Jul 2002 14:17:31 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714121731.GA15055@win.tue.nl>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714140153.A26469@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 02:01:53PM +0200, Vojtech Pavlik wrote:

> > mice: PS/2 mouse device common for all mice
> > atkbd.c: Sent: f5
> > atkbd.c: Received fe
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> Ok. So this is the cause. The driver gets a '0xfe' response, which means
> "error, command not supported, or device not present'.
> 
> A keyboard must support the 0xf5 command ('reset').

I have not followed the discussion and probably say something
entirely out of context. But from the good old days I seem to
recall commands 0xff "reset", 0xf5 "set defaults and deactivate"
and reply 0xfe "please resend".

In principle nothing is wrong when one gets a 0xfe.
The request is just: please say that again.

Andries
