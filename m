Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSKVTIA>; Fri, 22 Nov 2002 14:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSKVTIA>; Fri, 22 Nov 2002 14:08:00 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:29121 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP
	id <S265211AbSKVTH7>; Fri, 22 Nov 2002 14:07:59 -0500
Date: Fri, 22 Nov 2002 17:14:54 -0200
From: Lucio Maciel <abslucio@terra.com.br>
To: Michael Dreher <dreher@math.tu-freiberg.de>
Cc: linux-kernel@vger.kernel.org, perex@perex.cz
Subject: Re: sleeping function called from illegal context at mm/slab.c:1304
Message-Id: <20021122171454.4905404f.abslucio@terra.com.br>
In-Reply-To: <200211221933.22395.dreher@math.tu-freiberg.de>
References: <200211221933.22395.dreher@math.tu-freiberg.de>
Organization: absoluta
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__22_Nov_2002_17:14:54_-0200_082ea3f0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__22_Nov_2002_17:14:54_-0200_082ea3f0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hello..

Try this patch..

best regards
On Fri, 22 Nov 2002 19:33:22 +0100
Michael Dreher <dreher@math.tu-freiberg.de> wrote:

> Hello all,
> 
> this is with 2.5.48 (and several kernels before).
> 
> Best regards,
> Michael
> 
> 
> 
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1304
> kernel: Call Trace:
> kernel:  [__might_sleep+84/96] __might_sleep+0x54/0x60
> kernel:  [kmem_flagcheck+30/80] kmem_flagcheck+0x1e/0x50
> kernel:  [kmalloc+75/288] kmalloc+0x4b/0x120
> kernel:  [<e08a80bb>] build_via_table+0x5b/0x190 [snd-via82xx]
> kernel:  [__delay+19/48] __delay+0x13/0x30
> kernel:  [<e08a858e>] snd_via82xx_setup_periods+0x2e/0x130 [snd-via82xx]
> kernel:  [<e08a888e>] snd_via82xx_playback_prepare+0x7e/0x90 
> [snd-via82xx]
> kernel:  [<e0897ed1>] snd_pcm_prepare+0x21/0x210 [snd-pcm]
> kernel:  [<e0897fd9>] snd_pcm_prepare+0x129/0x210 [snd-pcm]
> kernel:  [<e0899ce6>] snd_pcm_common_ioctl1+0x1d6/0x2b0 [snd-pcm]
> kernel:  [<e089a05e>] snd_pcm_playback_ioctl1+0x29e/0x2b0 [snd-pcm]
> kernel:  [<e089a300>] snd_pcm_playback_ioctl+0x20/0x30 [snd-pcm]
> kernel:  [sys_ioctl+537/624] sys_ioctl+0x219/0x270
> kernel:  [error_code+45/56] error_code+0x2d/0x38
> kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

--Multipart_Fri__22_Nov_2002_17:14:54_-0200_082ea3f0
Content-Type: application/octet-stream;
 name="via82xx.diff"
Content-Disposition: attachment;
 filename="via82xx.diff"
Content-Transfer-Encoding: base64

LS0tIHNvdW5kL3BjaS92aWE4Mnh4LmN+CTIwMDItMTEtMjIgMTc6MDY6MzAuMDAwMDAwMDAwIC0w
MjAwCisrKyBzb3VuZC9wY2kvdmlhODJ4eC5jCTIwMDItMTEtMjIgMTc6MDY6MzguMDAwMDAwMDAw
IC0wMjAwCkBAIC0yMjIsNyArMjIyLDcgQEAKIAkJCXJldHVybiAtRU5PTUVNOwogCX0KIAlpZiAo
ISBkZXYtPmlkeF90YWJsZSkgewotCQlkZXYtPmlkeF90YWJsZSA9IGttYWxsb2Moc2l6ZW9mKCpk
ZXYtPmlkeF90YWJsZSkgKiBWSUFfVEFCTEVfU0laRSwgR0ZQX0tFUk5FTCk7CisJCWRldi0+aWR4
X3RhYmxlID0ga21hbGxvYyhzaXplb2YoKmRldi0+aWR4X3RhYmxlKSAqIFZJQV9UQUJMRV9TSVpF
LCBHRlBfQVRPTUlDKTsKIAkJaWYgKCEgZGV2LT5pZHhfdGFibGUpCiAJCQlyZXR1cm4gLUVOT01F
TTsKIAl9Cg==

--Multipart_Fri__22_Nov_2002_17:14:54_-0200_082ea3f0--
