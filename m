Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUJTW77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUJTW77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270474AbUJTWb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:31:27 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:63550 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268993AbUJTW1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:27:42 -0400
Subject: Re: belkin usb serial converter (mct_u232), break not working
From: Paul Fulghum <paulkf@microgate.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200410202308.02624.thomas@stewarts.org.uk>
References: <200410201946.35514.thomas@stewarts.org.uk>
	 <1098307331.2818.15.camel@deimos.microgate.com>
	 <200410202308.02624.thomas@stewarts.org.uk>
Content-Type: text/plain
Message-Id: <1098311228.6006.3.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 17:27:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 17:08, Thomas Stewart wrote:

> take porttest.c:
> #include <sys/fcntl.h>
> #include <sys/ioctl.h>
> main(int argc, char ** argv) {
>         int fd = open(argv[1], O_RDWR|O_NOCTTY);
>         ioctl(fd, TCSBRKP, 20);
>         close(fd);
> }
> 
> $ time ./porttest /dev/ttyS0
> real    0m2.001s
> user    0m0.001s
> sys     0m0.000s
> 
> A standard serial port with a 2 second break (20*100ms), takes as expected 
> just over 2 seconds.
> 
> $ time ./porttest /dev/ttyUSB1
> real    0m0.004s
> user    0m0.000s
> sys     0m0.001s
> 
> However with the USB converter instead, it takes 5 ms to complete. Much 
> shorter than expected.
> 
> Is it a driver issue?

Can you record and display the return code from the ioctl()?

Thanks

-- 
Paul Fulghum
paulkf@microgate.com


