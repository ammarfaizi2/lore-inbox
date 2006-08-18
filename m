Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWHRUZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWHRUZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWHRUZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:25:08 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:33945 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932508AbWHRUZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:25:06 -0400
Message-ID: <44E6221D.4040008@compro.net>
Date: Fri, 18 Aug 2006 16:25:01 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Serial issue
References: <1155862076.24907.5.camel@mindpipe> <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe>  <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe> <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com> <1155928885.2924.40.camel@mindpipe> <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Fri, 18 Aug 2006, Lee Revell wrote:
> 
>> On Fri, 2006-08-18 at 15:15 -0400, linux-os (Dick Johnson) wrote:
>>> A file-transfer protocol??? Has he got hardware the __required__
>>> hardware flow-control enabled on both ends? One can't spew
>>> high-speed serial data out forever without a hardware handshake.
>>>
>> Interesting you should mention that.  As a matter of fact I have to
>> disable all flow control or the serial console doesn't even work.  I
>> considered this a minor issue and had forgotten about it.
>>
>> But, in polled mode with no flow control I can transfer a 10MB file.
>> There are a lot of retransmits but it works.
>>
>> Lee
>>
> 
> Using RS-232C for file transfer and as a serial console are two
> different things. Many terminals and terminal emulators don't
> even activate RTS/CTS. If you are just getting data from the
> output of a UART to view on a screen, the data usually comes
> in spurts, a line at a time, and a screen at a time. There
> is plenty of time for the receiving terminal to write the
> stuff to the screen.
> 
> However, with file transfers, data streams with no breaks.
> There needs to be time for these buffers of data to be written
> to files, etc., or else you eventually run out of buffers even
> if no interrupts are ever lost. Therefore, you must use hardware
> handshake. In other words, you need to connect your machines
> together with a complete null-modem cable, not just three wires.
> Then both machines need to cooperate, i.e., the receiving machine
> needs to lower CTS before its buffers get full and the sender,
> must look at its RTS bit and wait for it to go false before
> sending anymore data. Failure to do this __will__ result in
> lost data.
> 

Don't mean to but it but:

Take it from someone who actually still uses dumb terminals every day, any thing
over 9600 baud still requires some kind of flow control for reliable consistent
operation. Software (Xon/Xoff) and or hardware (RTS/RTS/DTE) flow control.


Mark

