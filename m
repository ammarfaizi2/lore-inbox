Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSK0QT4>; Wed, 27 Nov 2002 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSK0QT4>; Wed, 27 Nov 2002 11:19:56 -0500
Received: from [81.2.122.30] ([81.2.122.30]:13064 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S263291AbSK0QTz>;
	Wed, 27 Nov 2002 11:19:55 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211271637.gARGbZl6001478@darkstar.example.net>
Subject: Re: modversions problem with 2.5.48 + .49
To: kernelmarc@tirwhan.org (Marc)
Date: Wed, 27 Nov 2002 16:37:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DE4F143.4050106@tirwhan.org> from "Marc" at Nov 27, 2002 04:22:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I cannot successfully make dep on either 2.5.48 or 2.5.49

You don't need to anymore.

> My steps are:
> 
> cd ~/kernel/
> tar xvzf linux-2.5.49.tar.gz
> cd linux-2.5.49
> make mrproper
> make config - (output below), choosing all default options except for 
> processor type
> make dep     - which fails with following output:

Try:

cd ~/kernel/
tar -xvzf linux-2.5.49.tar.gz
cd linux-2.5.49
make config, (or make menuconfig, etc)
make bzImage
cp arch/i386/boot/bzImage /path/to/kernel/images

then configure your bootloader and reboot.

John.
