Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSAGH0A>; Mon, 7 Jan 2002 02:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSAGHZu>; Mon, 7 Jan 2002 02:25:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64264 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287817AbSAGHZi>; Mon, 7 Jan 2002 02:25:38 -0500
Message-ID: <3C394C36.C9041722@zip.com.au>
Date: Sun, 06 Jan 2002 23:20:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C38BC19.72ECE86@zip.com.au>,
		<3C34024A.EDA31D24@zip.com.au>
		<3C33E0D3.B6E932D6@zip.com.au>
		<3C33BCF3.20BE9E92@cyclades.com>
		<200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
		<200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca>
		<3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> > > Why exactly is just "ttyS" broken?
> >
> > umm..  Because it doesn't tell the user which serial port the
> > message pertains to?
> 
> Exactly where is it broken? I look at my dmesg output and things look
> fine.
> 

Try disabling devfs.

At the head-of-thread, Ivan said:


> This was spotted by a Cyclades customer who was getting overrun msgs
> as:
> 
> ttyC: 1 input overrun(s)
> 
> After he changed the driver.name to be "ttyC%d", he started to get
> properly formatted msgs, such as:
> 
> ttyC39: 1 input overrun(s)
> 
> This problem would happen on any msg that used the function
> tty_name() to get the TTY name, and after the change the problem
> disappeared completely.

-
