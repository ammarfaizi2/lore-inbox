Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132711AbRBENAa>; Mon, 5 Feb 2001 08:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRBENAW>; Mon, 5 Feb 2001 08:00:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60033 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132711AbRBENAI>; Mon, 5 Feb 2001 08:00:08 -0500
Date: Mon, 5 Feb 2001 07:59:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mathieu Dube <mathieu_dube@videotron.ca>
cc: linux-kernel@vger.kernel.org, davids@webmaster.com
Subject: RE: accept
In-Reply-To: <01020411401700.00110@grndctrl>
Message-ID: <Pine.LNX.3.95.1010205075503.27621A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Feb 2001, Mathieu Dube wrote:

> Ok, but fd 0 cant be a valid socket since its the stdin
> 
Sure it can:

	close(0);
	close(1);
	close(2);
	fd = socket(....);
	dup....etc, for stdout and stderr.

That said, never, never, ever, check the value of the errno global
unless a function call returned an error. Many/most/all C runtime
procedures don't touch that variable unless an error occurred.
So, reading its value will show the results of something that
happened hours ago (line an interrupted system call).


> I posted that on this mailing list coz I thought that this might be a scaling
> problem since it happens when theres already several clients connected to the
> server



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
