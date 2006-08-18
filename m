Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWHRU5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWHRU5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWHRU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:57:55 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:34774 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S964925AbWHRU5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:57:54 -0400
Message-ID: <44E629CE.5000809@compro.net>
Date: Fri, 18 Aug 2006 16:57:50 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Mark Hounschell <markh@compro.net>, Lee Revell <rlrevell@joe-job.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial issue
References: <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe> <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe> <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com> <1155928885.2924.40.camel@mindpipe> <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com> <44E6221D.4040008@compro.net> <1155932916.2924.47.camel@mindpipe> <44E623EB.1060908@compro.net> <20060818203607.GK21101@flint.arm.linux.org.uk>
In-Reply-To: <20060818203607.GK21101@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Aug 18, 2006 at 04:32:43PM -0400, Mark Hounschell wrote:
>> Lee Revell wrote:
>>> On Fri, 2006-08-18 at 16:25 -0400, Mark Hounschell wrote:
>>>> Take it from someone who actually still uses dumb terminals every day,
>>>> any thing over 9600 baud still requires some kind of flow control for
>>>> reliable consistent operation. Software (Xon/Xoff) and or hardware
>>>> (RTS/RTS/DTE) flow control.
>>>>
>>> Any idea why the serial console does not work at all with flow control
>>> enabled (regardless of whether the host runs Linux or another OS)?
>>>
>>> Lee
>>>
>>>
>> Your cable is probably wrong.  Both ends have to be using the type of flow
>> control your cable is wired for.
> 
> Not quite true.  You can use XON/XOFF or hardware flow with a fully
> populated cable, but if you have a sparsely populated cable (RX,TX,GND
> only) then hardware flow control can't (and won't) work.
> 

Ok I should have said.  Both ends have to be using the type of flow
control your cable is wired for if you are using hardware flow control and you
expect it to work correctly.

If you have the hardware signals wired wrong, depending on how it is actually
wrong, and you are using hardware flow control, anything to nothing can happen.
I have incorrectly tied CTS to gnd(false) on both ends, I have CTS/RTS flow
control enabled, why don't I get any data on either end?

Is there a definition of a fully populated cable? Obviously if all you have
wired it xmit/rcve hardware flow control won't work.

Mark
