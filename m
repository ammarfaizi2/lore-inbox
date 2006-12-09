Return-Path: <linux-kernel-owner+w=401wt.eu-S1754278AbWLIVKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbWLIVKV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756305AbWLIVKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:10:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:27218 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbWLIVKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:10:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=hut6WItGo1tTTqRRlyUwdK3+jS2RUszMaYJYo/kBkgg1AMvwx34shMoGxU9xQxg5VdbfoS70AS7e1jY+iaK+Da2wP1vKMSUtDaLd7GKylLp7j+wsgAoAiJiXXIrgL4ts59/r80LeuN8kGa264EbfPIlgZkwaVsWclMINSEFLs4M=
Message-ID: <457B262E.4040305@gmail.com>
Date: Sat, 09 Dec 2006 22:09:43 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.19-g200d018e build #180 failed
References: <200612091908.12521.toralf.foerster@gmx.de>
In-Reply-To: <200612091908.12521.toralf.foerster@gmx.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toralf Förster wrote:
> Hello,
> 
> the build with the attached .config failed, make ends with:
> ...
>   CC      lib/rwsem.o
>   CC      lib/semaphore-sleepers.o
>   CC      lib/sha1.o
>   CC      lib/string.o
>   CC      lib/vsprintf.o
>   AR      lib/lib.a
>   LD      arch/i386/lib/built-in.o
>   CC      arch/i386/lib/bitops.o
>   AS      arch/i386/lib/checksum.o
>   CC      arch/i386/lib/delay.o
>   AS      arch/i386/lib/getuser.o
>   CC      arch/i386/lib/memcpy.o
>   AS      arch/i386/lib/putuser.o
>   AS      arch/i386/lib/semaphore.o
>   CC      arch/i386/lib/strstr.o
>   CC      arch/i386/lib/usercopy.o
>   AR      arch/i386/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/main.o
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `isicom_probe':
> isicom.c:(.text+0x31f44): undefined reference to `pci_request_region'
> isicom.c:(.text+0x31fcf): undefined reference to `pci_release_region'
> drivers/built-in.o: In function `isicom_remove':
> isicom.c:(.text+0x320f9): undefined reference to `pci_release_region'
> drivers/built-in.o: In function `sx_remove_card':
> sx.c:(.text+0x35cf3): undefined reference to `pci_release_region'
> make: *** [.tmp_vmlinux1] Error 1

Yeah, Randy Dunlap posted a patch altering Kconfig on Nov 29; I'm waiting for
the next -mm release to fix the code.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
