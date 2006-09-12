Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWILMFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWILMFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWILMFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:05:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6084 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932257AbWILMFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:05:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=WJrTTp/abLzJzEnivfkRHnphpXkjVpYW3ESb3ZiEmP2cwuMo06h/bhvIUJ2t4cocmn79CtGkTRkbQQpcpgLDb5cxprapT3jejpmrzTlP2rHZBkvwc7ucBvjJgTOSzkjLsz8PPNDalCGaO4J7NYUshnxnbkyz3kf1ILtDUSNNQro=
Message-ID: <4506A295.6010206@gmail.com>
Date: Tue, 12 Sep 2006 14:05:41 +0200
From: guest01 <guest01@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.5) Gecko/20060719 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OT: calling kernel syscall manually
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry guys, this question is a little bit off topic, but maybe someone
has an answer, I am sure that there is a simple one. :-)

Ok, I have to find 3 possibilities to create a directory with 3 small c
programs:
1 -> using libc: mkdir(dir,mode)
2 -> using libcsyscall:  syscall(__NR_mkdir, "mkdirLibcSyscall", 0777);
3 -> using kernel directly

Ok, the third one is a little bit tricky, at least for me. I found an
example for lseek, but I don't know how to convert that for mkdir. I
don't know the necessary arguments, ..

> #include <linux/unistd.h>
> 
> _syscall5(int, _llseek, unsigned int, fd,
>           unsigned long, offset_high, unsigned long, offset_low,
>           long long *, result, unsigned int, origin)
> 
> long long
> my_llseek(unsigned int fd, unsigned long long offset, unsigned int origin) {
>           long long result;
>           int retval;
> 
>           retval = _llseek (fd, offset >> 32, offset & 0xffffffff,
>                             &result, origin);
>           return (retval == -1) ? -1 : result;
> }

Any help would be much appreciated. Thxs

regards
peda
