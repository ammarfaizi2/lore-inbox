Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289358AbSA1UBQ>; Mon, 28 Jan 2002 15:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289348AbSA1T5x>; Mon, 28 Jan 2002 14:57:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17538 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289358AbSA1Tzq>; Mon, 28 Jan 2002 14:55:46 -0500
Date: Mon, 28 Jan 2002 14:58:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kevin Breit <mrproper@ximian.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet data corruption?
In-Reply-To: <1012250404.5401.6.camel@kbreit.lan>
Message-ID: <Pine.LNX.3.95.1020128145238.19243A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2002, Kevin Breit wrote:

> Hi,
> 	The other night, my friend was sending me a video over the internet. 
> We tried http, ftp, and other protocols, using different download
> applications.  It seemed to be corrupt, the same way, everytime.  It
> wouldn't work, and had a different md5sum than the "good" version on my
> friend's computer.  Eventually we got it working.
> 	The same issue came up again today.  I uploaded my Java project on my
> professor's server and it gives me an error.  However, if I load the
> html file with the Java applet in my web browser from this hard disk
> (instead of from the prof's), it works.
> 	I am wondering if there is some sort of corruption going on here.  I am
> using Red Hat's 2.4.9-21 kernel.
> 
> Thanks
> 
> Kevin Breit
> 

Every TCP/IP data packet is check-summed. Every Ethernet packet has
a CRC. If you have data corruption it is caused either by a memory
error or, most likely, you did not set the ftp data-transfer mode
to binary `set bin` when you have the 'ftp>' prompt.

Also, text-files (Java Script) on DOS-based stuff (like windows) use
both a '\r' and a '\n' at the end of each line. Unix/Linux uses '\n'
only. I am pretty sure this is not a kernel issue.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


