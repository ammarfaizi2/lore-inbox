Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310287AbSCLBJD>; Mon, 11 Mar 2002 20:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310264AbSCLBIi>; Mon, 11 Mar 2002 20:08:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33553 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310279AbSCLBHR>; Mon, 11 Mar 2002 20:07:17 -0500
Subject: Re: Upgrading Headers?
To: bqueen@nas.nasa.gov (Brian S Queen)
Date: Tue, 12 Mar 2002 01:22:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203120100.RAA00468@marcy.nas.nasa.gov> from "Brian S Queen" at Mar 11, 2002 05:00:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kb0A-0002PM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When a person switches to, or upgrades a kernel, how do they upgrade the
> associated header files?  The headers in /usr/include won't match the kernel.
> I don't see anything about that in the documentation.

Thats intentional.

> When I want to program with my new kernel I need to use the new headers, so I 
> have to use #include <linux/fcntl.h> instead of #include <fcntl.h>.  This 
> seems odd.

You want a newer glibc basically (or for specific cases just fix the headers)
The point is that glibc<->app and kernel<->glibc do not match. Eg glibc had
32bit uid_t well before the kernel did - as a result moving the kernel
to 32bit uid has been almost painless.
