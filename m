Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTDJQwa (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTDJQw3 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:52:29 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:5273 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264075AbTDJQwS (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:52:18 -0400
Date: Thu, 10 Apr 2003 11:03:30 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre7: error compiling aic7(censored)/aicasm/aicasm.c
Message-ID: <539290000.1049994210@aslan.btc.adaptec.com>
In-Reply-To: <20030406125804.GW20044@fs.tum.de>
References: <20030406125804.GW20044@fs.tum.de>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <--  snip  -->
> 
> gcc-2.95 -D__KERNEL__ 
> -I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -D__KERNEL__ 
> -I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -e stext  
> aicasm/aicasm.c   -o aicasm/aicasm
> /usr/bin/ld: warning: cannot find entry symbol stext; defaulting to 08048760

This is probably due to the misplaced endif in the currently committed
drivers/scsi/aic7xxx/Makefile.  Updated versions of the Makefile/driver
can be found here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

