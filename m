Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290047AbSBSU6A>; Tue, 19 Feb 2002 15:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290075AbSBSU5u>; Tue, 19 Feb 2002 15:57:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290047AbSBSU5j>;
	Tue, 19 Feb 2002 15:57:39 -0500
Message-ID: <3C72BC0C.821EAB90@zip.com.au>
Date: Tue, 19 Feb 2002 12:56:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ENOTTY from ext3 code?
In-Reply-To: <20020219190932.GA274@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> ext3/ioctl.c:
> 
> ...
>         return -ENOTTY;
> 
> Does it really make sense to return "not a typewriter" from ext3
> ioctl?

ERRORS
       ...

       ENOTTY d  is  not  associated  with  a  character  special
              device.

       ENOTTY The specified request does not apply to the kind of
              object that the descriptor d references.


Lots and lots of ioctls return ENOTTY when passed a request
which they don't understand.  There's probably a great reason
for this, but I can't immediately think what it might be.

-
