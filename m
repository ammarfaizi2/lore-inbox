Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbRG3UGQ>; Mon, 30 Jul 2001 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbRG3UGG>; Mon, 30 Jul 2001 16:06:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39307 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267725AbRG3UFu>;
	Mon, 30 Jul 2001 16:05:50 -0400
Date: Mon, 30 Jul 2001 16:05:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alon Ziv <alonz@nolaviz.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
In-Reply-To: <018101c11914$40bc3100$910201c0@zapper>
Message-ID: <Pine.GSO.4.21.0107301555310.19391-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Mon, 30 Jul 2001, Alon Ziv wrote:

> I wonder...  May the initramfs be used also for loading modules ???
> Hmm... it will require a pico-insmod that can run in the limited initramfs
> environment, but I believe that's all !
> Reminder-to-self: try this at home...
> This may bring the long-awaited revolution in kernel building (everything
> is a module!)

Why not? Kernel unpacks cpio archive on root (which lives on ramfs) and
starts /init. That's it - after that you are in userland and free to
do everything you would normally do. If there's a variant of insmod that
would not bring glibc for a ride...

