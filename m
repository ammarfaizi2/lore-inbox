Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTAFFRd>; Mon, 6 Jan 2003 00:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTAFFRc>; Mon, 6 Jan 2003 00:17:32 -0500
Received: from [209.195.52.121] ([209.195.52.121]:41953 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S266064AbTAFFR3>; Mon, 6 Jan 2003 00:17:29 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Date: Sun, 5 Jan 2003 21:13:23 -0800 (PST)
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
In-Reply-To: <23180000.1041829217@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0301052105460.25514-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jan 2003, Justin T. Gibbs wrote:

> Date: Sun, 05 Jan 2003 22:00:17 -0700
> From: Justin T. Gibbs <gibbs@scsiguy.com>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
> Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
>
> > other then the memmap error (in my case device 0:10:0 I get the first
> > three lines of the driver init and then nothing. the machine
> > completely locks up (driver version on .54 is 6.2.25 but I've
> > had this same problem since .50)
>
> Some things to try:
>
> o  Turn on the nmi_watchdog.  See the help file in the kernel Documentation
>    director on how to enable it for your system.

I will try this later

> o  Compile in the debugging code for the aic7xxx driver and turn on some
>    debugging options.  Use your favorite kernel configuration utility to
>    enable the debug code and use an aic7xxx command line like:
>
> 	aic7xxx=verbose.debug:0x12ff

I added this to lilo and it gets a series of messages that quickly scroll
off the screen

it starts with slave alloc 0
then starts the DV process and goes from state 0 to state 1, gives a
couple errors that I couldn't get and then goes into a loop

the looping messages are

sending INQ
timeout while doing DV command 12
command completed status=0x90000
entering ahc_linux_dv_transition, state=1, status=0x14005, cmd->result=0x90000
going from state 1 to state 1

thanks for your help, I was beginning to wonder since nobody had responded
to my previous messages.

David Lang

> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
