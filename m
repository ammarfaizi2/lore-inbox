Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbTAGUuQ>; Tue, 7 Jan 2003 15:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267501AbTAGUuQ>; Tue, 7 Jan 2003 15:50:16 -0500
Received: from CPE0010e000064f.cpe.net.cable.rogers.com ([24.156.126.78]:31437
	"EHLO supagal") by vger.kernel.org with ESMTP id <S267516AbTAGUuP>;
	Tue, 7 Jan 2003 15:50:15 -0500
Message-ID: <3E1B3F6E.9050902@waychison.com>
Date: Tue, 07 Jan 2003 15:58:23 -0500
From: Mike Waychison <mike@waychison.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Undelete files on ext3 ??
References: <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>
>There is a project waiting for someone who wants
>to contribute. It only slightly involves the kernel,
>but is quite useful.
>
>As more people are switching from the Redmond stuff
>to Linux, many have "learned" from the Redmond stuff
>that `rm` isn't permanent. You can always get it
>back from the `wastebasket`.  Of course, the Unix
>gurus know you can't. Therefore, it's time for somebody
>to put a 'dumpster` in all the Linux file-systems.
>Somebody should then modify `rm` and the kernel unlink
>to `mv' files to the dumpster directory on the
>file-system, instead of really deleting them. Then,
>just like the Redmond stuff, a separate program can
>be used to clear out the "dumpster" or `mv` them back.
>
>Since sys_unlink() takes only a path-name, there isn't
>a current mechanism whereby it could take a flag to
>tell it to 'really' delete a file (or is there?). So,
>maybe we need a new kernel function? Just hacking existing
>utilities won't do the whole thing because we need programs
>that delete files to transparently put them into the
>dumpster as well.
>
>The wastebasket should be called a hopper or a dumpster so
>Redmond doesn't get confused and send lawyers.
>
>  
>

libtrash - http://www.m-arriaga.net/software/libtrash/

It implements this functionality in userspace by intercepting libc calls 
on a very configurable level (per-user/per-directory).  I've tried it 
out in the past and it seems to work nicely, although some temp files 
dropped by programs are sometimes also dropped into the ~/trash directory..

Mike Waychison

>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>Why is the government concerned about the lunatic fringe? Think about it.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>



