Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRCAVIY>; Thu, 1 Mar 2001 16:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRCAVIN>; Thu, 1 Mar 2001 16:08:13 -0500
Received: from cr296314-a.pr1.on.wave.home.com ([24.112.97.56]:10502 "EHLO
	prophit.maincube.net") by vger.kernel.org with ESMTP
	id <S130013AbRCAVIF>; Thu, 1 Mar 2001 16:08:05 -0500
Date: Thu, 1 Mar 2001 15:40:28 -0500 (EST)
From: David Priban <david2@maincube.net>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: i2o & Promise SuperTrak100
In-Reply-To: <3A9D857C.CF9EF272@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0103011509270.3296-100000@prophit.maincube.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Andrew Morton wrote:

> This untested patch should fix the scheduling-in-interrupt
> thing.
> 
> 
> --- kernel/sys.c.orig	Thu Mar  1 10:06:14 2001
> +++ kernel/sys.c	Thu Mar  1 10:07:43 2001
> @@ -330,6 +330,12 @@

Yes, this fixed the oops. Now it's possible to ctrl-alt-del reboot
when i2o_block hangs. It still happens four times out of five reboots
meaning it is intermittent. (Timing as Alan mentioned - goes away when
DEBUG enabled) I have to put in some better HD's and test stability 
of the filesystem on this device. Any suggestions what's best way to
do it to get some meaningful results?

Thanks David


