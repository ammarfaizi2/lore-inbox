Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbUJ0TcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbUJ0TcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbUJ0TVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:21:46 -0400
Received: from alog0319.analogic.com ([208.224.222.95]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262581AbUJ0TA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:00:59 -0400
Date: Wed, 27 Oct 2004 14:58:08 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Lei Yang <lya755@ece.northwestern.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: loopback on block device
In-Reply-To: <417FE703.3070608@ece.northwestern.edu>
Message-ID: <Pine.LNX.4.61.0410271452390.4669@chaos.analogic.com>
References: <417FE703.3070608@ece.northwestern.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Lei Yang wrote:

> Hello,
>
> Here is a question for loopback device. As far as I understand,  the loopback 
> device is used to mount files as if they were block devices.
>
> Then Why I could do "losetup -e XOR /dev/loop0 /dev/ram0" ? Notice that ram0 
> is not mounted anywhere and does not have a filesystem on it. I've tried that 
> command and there seems to be no error. I got confused and looked into 
> loop.c, it seems to me that a loopback device should be associated with a 
> "backing file", why would it work on a block device anyway?
>
> I'd appreciate your comments greatly!
>
> TIA,
> Lei
>

`man losetup`
You just set up the loop device to enable encryption on
/dev/ram0. /dev/ram0 is a "file". It's a special-file,
but a file nevertheless. It can contain a file-system,
therefore act as a RAM disk, but it doesn't have to.

In principle, you could make an encrypted file-system
in which you couldn't even know what kind of file-
system it was, without an encryption key.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached and reviewed by John Ashcroft.
                  98.36% of all statistics are fiction.
