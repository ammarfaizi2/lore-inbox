Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293538AbSBZITy>; Tue, 26 Feb 2002 03:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293539AbSBZITo>; Tue, 26 Feb 2002 03:19:44 -0500
Received: from AGrenoble-202-1-1-87.abo.wanadoo.fr ([80.14.157.87]:48547 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S293538AbSBZITg>;
	Tue, 26 Feb 2002 03:19:36 -0500
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
Date: 26 Feb 2002 07:46:42 GMT
Organization: Home, Grenoble, France
Message-ID: <a5feh2$bvs$1@lyon.ram.loc>
In-Reply-To: <2871.1014671286@nice.ram.loc> <E16fTly-0006Va-00@the-village.bc.nu>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <E16fTly-0006Va-00@the-village.bc.nu>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk> from ml.linux.kernel:
:Neither. You asked for 8K the kernel allows a bit more for BSD compatibility
:and other things. You query and it gives back the size it chose

I understand the kernel can choose to allocate more than requested.
Even double the size.  But it should be consistent, i.e. if when I request
x it allocates 2x, then when I ask the size, I want to know x, not 2x.
Otherwise, how can the application behave sanely if it want to vary the
size?

Linux seems to be the only kernel to lie like that.  It's not consistent.
The aim is not for the application to accurately measure the amount of
kernel resources used by sockets, it's to adjust the (perceived) size of the
socket buffer.

If I can't use the returned value from getsockopt(SO_SNDBUF) to do a
setsockopt(SO_SNDBUF), then it's broken!  You'll have a hard time convincing
me otherwise.

Now whether it should be fixed is another matter.

Raphael
