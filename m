Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263318AbRFRVYU>; Mon, 18 Jun 2001 17:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbRFRVYK>; Mon, 18 Jun 2001 17:24:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263318AbRFRVX6>; Mon, 18 Jun 2001 17:23:58 -0400
Date: Mon, 18 Jun 2001 17:23:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kelledin Tane <runesong@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why can't I flush /dev/ram0?
In-Reply-To: <3B2E6EA3.3DED7D95@earthlink.net>
Message-ID: <Pine.LNX.3.95.1010618172045.4490A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Kelledin Tane wrote:

> At this point, I'm trying to get an initrd working properly.  So far, it
> works, the system boots, etc. etc., but whenever I try to do a "blockdev
> --flushbufs /dev/ram0", I get "device or resource busy"
> 
> When I mount the filesystem to check it out, nothing appears to have
> anything open on the filesystem.  So why am I not able to flush it
> clean?
> 
> This is kernel 2.4.5 stock, btw.
> 
> Kelledin
> 

If you have a directory called /initrd, in your root file-system,
you may find that the old initrd is still mounted:

Script started on Mon Jun 18 17:22:20 2001
# ls /initrd
bin  dev  etc  lib  linuxrc  sbin
# umount /initrd
# ls /initrd
# exit
exit
Script done on Mon Jun 18 17:22:44 2001

Unmount it first.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


