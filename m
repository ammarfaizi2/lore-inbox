Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUDMFqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUDMFqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 01:46:31 -0400
Received: from [194.89.250.117] ([194.89.250.117]:42380 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S263355AbUDMFq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 01:46:28 -0400
From: Kim Holviala <kim@holviala.com>
To: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>
Subject: Re: 2.6.5 : problem with MS Intellimouse Explorer buttons when using X
Date: Tue, 13 Apr 2004 08:46:25 +0300
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20040410135327.GA12573@swszl.szkp.uni-miskolc.hu> <200404112216.33308.kim@holviala.com> <20040412101631.GA22555@swszl.szkp.uni-miskolc.hu>
In-Reply-To: <20040412101631.GA22555@swszl.szkp.uni-miskolc.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200404130846.26008.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 April 2004 13:16, Vitez Gabor wrote:

> > Try modprobing the even device (modprobe evdev) to get /dev/input/event?.
> > Then run hexdump -C /dev/input/event1 (or whatever even device represents
> > your mouse) to see what REALLY happens in the kernel.
>
> Everything looks OK: there are no superfluous mouse events. This is the
> output I got:
>
>[clip]
>
> So the mouse event regeneration in the kernel seems to be buggy.

I just checked with vanilla 2.6.5 and the virtual /dev/input/mice 
(and /dev/psaux) indeed work as advertised. The problem, as I thought would 
be, is with XFree and it's incredible bad mouse handling. The XFree code is 
so bad I don't wanna touch it, but someone ought to write a driver for the 
event device so that we wouldn't need the PS/2 emulation anymore.





Kim
