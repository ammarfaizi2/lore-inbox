Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283799AbRLEIfg>; Wed, 5 Dec 2001 03:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283801AbRLEIf1>; Wed, 5 Dec 2001 03:35:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:781 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283799AbRLEIfO>; Wed, 5 Dec 2001 03:35:14 -0500
Subject: Re: Fwd: binutils in debian unstable is broken.
To: akpm@zip.com.au (Andrew Morton)
Date: Wed, 5 Dec 2001 08:43:39 +0000 (GMT)
Cc: forming@home.com (Josh McKinney), linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <3C0DB3D6.9C86B865@zip.com.au> from "Andrew Morton" at Dec 04, 2001 09:42:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BXeV-0005Im-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem appears to be that the linker is now actually doing what
> we asked it to do, so the `remove_foo' entry in that table now points
> at a function which isn't going to be linked into the kernel.  Oh dear.

The ideal it seems would be for binutils to support passing a stub function
to use in such cases. That would keep the kernel stuff working nicely and
allow us to do panic("__exit code called"); if anyone actually did manage
to call one.
