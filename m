Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270584AbUJTXWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270584AbUJTXWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270472AbUJTXWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:22:48 -0400
Received: from wang.choosehosting.com ([212.42.1.230]:6801 "EHLO
	wang.choosehosting.com") by vger.kernel.org with ESMTP
	id S270276AbUJTXWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:22:07 -0400
From: Thomas Stewart <thomas@stewarts.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Subject: Re: belkin usb serial converter (mct_u232), break not working
Date: Thu, 21 Oct 2004 00:04:13 +0100
User-Agent: KMail/1.6.2
References: <200410201946.35514.thomas@stewarts.org.uk> <200410202308.02624.thomas@stewarts.org.uk> <1098311228.6006.3.camel@at2.pipehead.org>
In-Reply-To: <1098311228.6006.3.camel@at2.pipehead.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
X-PGP-Key: http://www.stewarts.org.uk/public-key.asc
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210004.13214.thomas@stewarts.org.uk>
X-Scanner: Exiscan on wang.choosehosting.com at 2004-10-21 00:22:04
X-Spam-Score: 0.0
X-Spam-Bars: /
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 23:21, you wrote:
> What kernel version are you running?

2.6.8.1

Well, a stock debian one out of sarge, kernel-image-2.6.8-1-686-smp, configs 
at http://www.stewarts.org.uk/stuff/config-2.6.8-1-686. There is not much 
difference between a stock 2.6.8.1 and the debian 2.6.8:-
http://www.stewarts.org.uk/stuff/debian.2.6.8.patch

On Wednesday 20 October 2004 23:27, you wrote:
> Can you record and display the return code from the ioctl()?

porttest.c:
#include <sys/fcntl.h>
#include <sys/ioctl.h>
main(int argc, char ** argv) {
        int r, fd = open(argv[1], O_RDWR|O_NOCTTY);
        r=ioctl(fd, TCSBRKP, 20);
        printf("%d\n", r);
        close(fd);
}

$ ./porttest /dev/ttyS0
0
$ ./porttest /dev/ttyUSB0
0

Regards
-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID  [0x68A70C48]
