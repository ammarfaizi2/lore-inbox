Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUJTW36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUJTW36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270566AbUJTWTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:19:23 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:49214 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269040AbUJTWQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:16:04 -0400
Message-ID: <4176E381.70008@microgate.com>
Date: Wed, 20 Oct 2004 17:15:29 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird M6a (Windows/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Stewart <thomas@stewarts.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: belkin usb serial converter (mct_u232), break not working
References: <200410201946.35514.thomas@stewarts.org.uk> <1098307331.2818.15.camel@deimos.microgate.com> <200410202308.02624.thomas@stewarts.org.uk>
In-Reply-To: <200410202308.02624.thomas@stewarts.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Stewart wrote:

>I've tyred various combinations of ioctl(fd, TCSBRKP, x) and tcsendbreak(fd, 
>x), where x is 2, 5, 10, 20 and 200.
>
>One thing I did notice is that no mater what the value I use, it always 
>finishes very quickly, there does not appear to be any duration.
>
>take porttest.c:
>#include <sys/fcntl.h>
>#include <sys/ioctl.h>
>main(int argc, char ** argv) {
>        int fd = open(argv[1], O_RDWR|O_NOCTTY);
>        ioctl(fd, TCSBRKP, 20);
>        close(fd);
>}
>
>$ time ./porttest /dev/ttyS0
>real    0m2.001s
>user    0m0.001s
>sys     0m0.000s
>
>A standard serial port with a 2 second break (20*100ms), takes as expected 
>just over 2 seconds.
>
>$ time ./porttest /dev/ttyUSB1
>real    0m0.004s
>user    0m0.000s
>sys     0m0.001s
>
>However with the USB converter instead, it takes 5 ms to complete. Much 
>shorter than expected.
>
>Is it a driver issue?
>  
>
Could be.
That test gives me more information.
I will look closer at the code and see if anything pops out.

Thanks,
Paul

--
Paul Fulghum
paulkf@microgate.com


