Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUDZQCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUDZQCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUDZQCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:02:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262927AbUDZQCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:02:09 -0400
Date: Mon, 26 Apr 2004 12:02:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Parag Nemade <cranium2003@yahoo.com>
cc: net dev <netdev@oss.sgi.com>, kernerl mail <linux-kernel@vger.kernel.org>,
       linux net <linux-net@vger.kernel.org>
Subject: Re: ping takes much time to myself?
In-Reply-To: <20040426154437.67657.qmail@web41402.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0404261159510.1494@chaos>
References: <20040426154437.67657.qmail@web41402.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004, Parag Nemade wrote:

> hello,
>      i want to add my own variables with icmp header.
> so i modified icmp header and added 2 variables to
> make icmp header len is 16 bytes. but when i build
> kernel image and boot it and then ping to myself why
> am i still getting 8 bytes header i.e. 84 bytes packet
> and why not 92 bytes packet?
> 56 bytes data + 16 bytes icmp header + 20 bytes ip
> header = 92 bytes
> also ping results shown below takes much time to ping
> myself. what gone wrong? how to make it behave like
> normal ping?


You don't modify the kernel to make a new ICMP packet!
You modify `ping` or make your own. If you change the
length of the header, it is no longer ICMP. Your
tools will misinterpret what you have.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


