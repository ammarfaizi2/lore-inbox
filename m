Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTKCREW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTKCREW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:04:22 -0500
Received: from pop.gmx.de ([213.165.64.20]:1685 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262133AbTKCREP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:04:15 -0500
X-Authenticated: #4512188
Message-ID: <3FA68AD4.6040803@gmx.de>
Date: Mon, 03 Nov 2003 18:05:24 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test9-mm1, nptl and nvidia issue
References: <3FA64C86.8040506@gmx.de> <200311031529.03820.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311031529.03820.bzolnier@elka.pw.edu.pl>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Please try to reproduce problem without nvidia _binary only_ module loaded.
> 
> <...>
> 
>>nvidia: no version magic, tainting kernel.
>>nvidia: module license 'NVIDIA' taints kernel.
>>0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496
> <...>
>>  [<f9a65dc9>] nv_kern_open+0xf3/0x228 [nvidia]
> <...>
>>  [<f9a7b377>] __nvsym00568+0x1f/0x2c [nvidia]
>>  [<f9a7d496>] __nvsym00775+0x6e/0xe0 [nvidia]
>>  [<f9a7d526>] __nvsym00781+0x1e/0x190 [nvidia]
>>  [<f9a7efac>] rm_init_adapter+0xc/0x10 [nvidia]
>>  [<f9a65dc9>] nv_kern_open+0xf3/0x228 [nvidia]

The problem doesn't appear with th GPL nv driver. Strange enough again 
with the nvidia binary driver, after several recompilings of the kernel 
the trace calls don't seem to appear but following message on modprobe 
(or perhaps it came that this time I manually loaded the module):
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
nvidia: Unknown symbol __might_sleep
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
Wed Jul 16 19:03:09 PDT 2003


So should i ask nvidia to compile a new driver or is this an issue with 
current kernel?

Prakash




