Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312817AbSDBPzt>; Tue, 2 Apr 2002 10:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312750AbSDBPzk>; Tue, 2 Apr 2002 10:55:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:46720 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312817AbSDBPze>; Tue, 2 Apr 2002 10:55:34 -0500
Date: Tue, 2 Apr 2002 10:54:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Get major number in Makefile
In-Reply-To: <20020402154200.30415.qmail@web14912.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020402105021.5638A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002, Michael Zhu wrote:

> Hi, smart gurus, I have a question while writing a
> Makefile file to install my device driver. In my
> device driver I dynamically allocate the major number
> of my device. In my Makefile I want to build a device
> node for my device under the /dev directory.
> 
>    mknod /dev/mydevice c $major 0;
> 
> So I need to know the major number of my deivce in the
> Makefile. I've read the Linux 'Device Driver'. There
> is some information about this. I use the following
> command to get the major number in my Makefile.
> 
> major=`awk "\\$2==\"$mymodule\" {printf \\$1}"
> /proc/devices`
> 
> But when I use the 'make install' command to install
> my driver, the following error returned.
> 
> major=`awk "\\==\"$ymodule\" {printf \\}"
> /proc/devices`
> awk: 0: unexpected character '\'
> awk: line 1: syntax error at or near ==
> make: *** [install] Error 2
> 
> What is wrong with my command? Can anyone tell me how
> to get the major number in Makefile.
> 
> Thank you very much.

`make` will interpret '$', you need $$ in the Makefile.
Also, you may not want to 'acquire' major numbers this way. Your
module may work only on the machine that built it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

