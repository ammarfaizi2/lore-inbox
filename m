Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTAPNyU>; Thu, 16 Jan 2003 08:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267090AbTAPNyU>; Thu, 16 Jan 2003 08:54:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8585 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267089AbTAPNyT>; Thu, 16 Jan 2003 08:54:19 -0500
Date: Thu, 16 Jan 2003 09:04:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux Geek <bourne@ToughGuy.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tar'ing /proc ???
In-Reply-To: <3E26BB8D.7070601@ToughGuy.net>
Message-ID: <Pine.LNX.3.95.1030116090109.4226A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Linux Geek wrote:

> Hi all,
> 
> I have been getting strange errors when i was trying to tar my /proc . 
> Are there any known issues/problems when we do such a thing ?
> Is it supposed to work at all ?
> 
> There is no reason as to why i am doing this :-) , just wanted to try out.
> 
> TIA , for all the help

Normally, you do `tar -clf`
                        |________ stay on the same file-system.
Otherwise toy need to use --exclude /proc.  Proc is a virtual
file-system that contains things like kcore. You can get into
a deadlock when reading kcore and you don't want this in your
backup anyway.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


