Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVIYJOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVIYJOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 05:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVIYJOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 05:14:48 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:6224 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750923AbVIYJOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 05:14:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nWo5vGVt0nBmMRoHW+mCcv68M7VifSqSjUg37SkkE+Uc9nnrcTBwETHKmYEiqFCLCJCHa4JuyS0dx4YGuiE+X7lMD9dOpFIigdO3kcYiQQGGszIgjEh53upiPduS7vTyZwnthU9DCCq1smLHxYbHt5wCKjdy80LLAB/thtI/2bc=
Message-ID: <1e62d1370509250214277ae075@mail.gmail.com>
Date: Sun, 25 Sep 2005 14:14:46 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: anup badhe <anup_223@yahoo.com>
Subject: Re: patching kgdb to linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050925035539.93945.qmail@web52407.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050925035539.93945.qmail@web52407.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/05, anup badhe <anup_223@yahoo.com> wrote:
> i am trying to debug the linux kernel 2.6.10 using
> kgdb.i have downloaded the kgdb patch 2.6.10-mm2.bz2.
> after bunzip2 it gives me the file 2.6.10-mm2.
>
> problem:
> 1- which type of file is this?
> 2- what patch command should i use(the options) so
> that i can patch it to linux 2.6.10.?
> 3-i have used the following command and it gives me
> some errors:
>
> root@localhost root]# patch -p1 <2.6.10-mm2
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this
> was:--------------------------|---
> linux-2.6.10/arch/alpha/defconfig  2004-10-18
> 16:55:19.000000000 -0700
> |+++ 25/arch/alpha/defconfig    2005-01-05
> 23:22:42.000000000 -0800
> --------------------------
> File to patch:
>

For patch the same kernel version is necessary ... means if the patch
is for 2.6.10-mm2 then you must have that kernel version .... means
first get 2.6.10 and then get mm2 patch for it .... apply patch to the
kernel and then apply patch for kgdb-2.6.10-mm2

mm2 patch you can get from kernel.org  .........

for applying patch do :

1) extract the kernel source to /usr/src/ directory then do cd to that
directory
2) run in kernel directorty  ....... (don't extract the patch file
from bz2 file)
            bzip2 -dc <patch_file_name> < patch -p1
the above command should succeed and have to show you patching file
msgs only ... don't show hunk or ask you something .... if its
happening then you patch and kernel are not syncronized and patch
wqon't be successful

3) then run the kgdb-2.6.10-mm2 patch like the above command in the
kernel directory ...

Then recompile kernel and do select kgdb option from the kernel
configuration menu

I hope this will work ...


--
Fawad Lateef
