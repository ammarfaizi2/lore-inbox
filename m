Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130634AbQKHCVw>; Tue, 7 Nov 2000 21:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131288AbQKHCVc>; Tue, 7 Nov 2000 21:21:32 -0500
Received: from mail.dotcast.com ([63.80.240.20]:50447 "EHLO
	DC-SRVR1.dotcast.com") by vger.kernel.org with ESMTP
	id <S130634AbQKHCVW>; Tue, 7 Nov 2000 21:21:22 -0500
Message-ID: <52C41B218DE28244B071A1B96DD474F6280153@DC-SRVR1.dotcast.com>
From: Marty Fouts <marty@dotcast.com>
To: "'David Lang'" <david.lang@digitalinsight.com>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: kernel@kvack.org, Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: RE: Installing kernel 2.4
Date: Tue, 7 Nov 2000 18:19:55 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a variation of #2 that is often good enough, based on some research
work done at (among other places) the Oregon Graduate Center.  I don't have
the references handy, but you might want to look for papers on "sandboxing"
authored there.

The basic idea is similar to the one used by many 'recompile on the fly'
systems, and involves marking the code in such a way that even inline pieces
can be replaced on the fly.  Very useful for things like system specific
memcpy implementations.

Marty


> -----Original Message-----
> From: David Lang [mailto:david.lang@digitalinsight.com]
> Sent: Tuesday, November 07, 2000 4:11 PM
> To: Jeff V. Merkey
> Cc: kernel@kvack.org; Martin Josefsson; Tigran Aivazian; Anil kumar;
> linux-kernel@vger.kernel.org
> Subject: Re: Installing kernel 2.4
> 
> 
> Jeff, the problem is not detecting the CPU type at runtime, 
> the problem is
> trying to re-compile the code to take advantage of that CPU 
> at runtime.
> 
> depending on what CPU you have the kernel (and compiler) can 
> use different
> commands/opmizations/etc, if you want to do this on boot you have two
> options.
> 
> 1. re-compile the kernel
> 
> 2. change all the CPU specific places from inline code to 
> function calls
> into a table that get changed at boot to point at the correct calls.
> 
> doing #2 will cost you so much performance that you would be 
> better off
> just compiling for a 386 and not going through the autodetect 
> hassle in
> the first place.
> 
> David Lang
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
