Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbUEFVJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUEFVJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUEFVJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:09:56 -0400
Received: from [81.219.144.6] ([81.219.144.6]:36110 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263027AbUEFVJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:09:54 -0400
Message-ID: <409AA99C.2060301@pointblue.com.pl>
Date: Thu, 06 May 2004 22:09:48 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Niccolo Rigacci <niccolo@rigacci.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2Gb file size limit on 2.4.24, LVM and ext3?
References: <20040506172152.GB17351@paros.rigacci.org>
In-Reply-To: <20040506172152.GB17351@paros.rigacci.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niccolo Rigacci wrote:

>Hi to all!
>
>I got a very strange problem: I can create files larger than 2
>Gb (even 5 Gb), but I can't read them back.
>
>- The simple "cat" command fails with:
>  # ls -la pippo
>  -rw-r--r--    1 root     root     2147483648 May  6 17:03 pippo
>  # cat pippo
>  cat: pippo: Operation not permitted
>
>- A file just 2kb under 2Gb, reads fine.
>
>- If I do an "strace cat pippo" it works fine! So how can
>  I trace the problem further?
>
>- The partition is an ext3 over LVM, kernel 2.4.24. Debian Woody
>  (glibc-2.2.5-11.5). Pentium 4 2.80GHz.
>  I tried both a quoted filesystem and a non quoted with same
>  results.
>
>- On a very similar system I have no problem, the main
>  difference is using LVM here.
>
>Is there a known issue? Can someone tell me how can trace down
>the problem?
>
>  
>
What's your glibc version ?

Old glibces didn't support large files.

--
GJ
