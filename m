Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWCGUXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWCGUXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWCGUXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:23:30 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:50461 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932374AbWCGUX3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:23:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jixmTq/8qt/N8D3+I2q0Lym2MntmU7OicK1Yv4C119TuXlhYu5OYtfjjiu2XOSuwhGaO6KmFV6ateHrpfAatb67dg77BKdzRwmlxed+PQRkVhuINFg6bqzR0W/cwcanIWhCH47ma7x2urBxxDCTIM001Pbha78TTi/Z+Zlzb/p0=
Message-ID: <9a8748490603071223k128ca34lc0fd9c416e4bca36@mail.gmail.com>
Date: Tue, 7 Mar 2006 21:23:25 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ivancso Krisztian" <ivan@swi.co.hu>
Subject: Re: PROBLEM: random freeze
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <440DCAF1.2020102@swi.co.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <440DCAF1.2020102@swi.co.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Ivancso Krisztian <ivan@swi.co.hu> wrote:
> Hi!
>
> I have an IBM xSeries 235, which randomly freeze. I tried many kernels.
>
[snip]
>
> Mar  7 11:28:07 db kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
> Mar  7 11:28:07 db kernel:  printing eip:
> Mar  7 11:28:07 db kernel: c019016d
> Mar  7 11:28:07 db kernel: *pde = 34359001
> Mar  7 11:28:07 db kernel: Oops: 0002 [#1]
> Mar  7 11:28:07 db kernel: SMP
> Mar  7 11:28:07 db kernel: Modules linked in: dm_mod nfs lockd nfs_acl sunrpc skge tg3
> Mar  7 11:28:07 db kernel: CPU:    3
> Mar  7 11:28:07 db kernel: EIP:    0060:[<c019016d>]    Not tainted VLI
> Mar  7 11:28:07 db kernel: EFLAGS: 00010206   (2.6.15.4-ibm-xeon-deltha)
> Mar  7 11:28:07 db kernel: EIP is at load_elf_binary+0x1e0/0xd0d
> Mar  7 11:28:07 db kernel: eax: 00000000   ebx: 00000005   ecx: f395ea00   edx: 00000400
> Mar  7 11:28:07 db kernel: esi: d6b32000   edi: c0373719   ebp: f6917a80   esp: d6b33eb8
> Mar  7 11:28:07 db kernel: ds: 007b   es: 007b   ss: 0068
> Mar  7 11:28:07 db kernel: Process db2jd (pid: 27511, threadinfo=d6b32000 task=f7d8a030)
> Mar  7 11:28:07 db kernel: Stack: f7367b80 00000034 f395ea00 00000120 c0372a5e 00000000 0000000e 0000000b
> Mar  7 11:28:07 db kernel:        c03ad5a8 000200d2 f7d8a030 ffffffff 00000014 f395ea00 00000000 00000000
> Mar  7 11:28:07 db kernel:        ffffffff 0001fc83 0001fc83 00000014 0807b2d0 00000000 00000000 00000000
> Mar  7 11:28:07 db kernel: Call Trace:
> Mar  7 11:28:07 db kernel:  [<c016ea1c>] copy_strings+0x1bf/0x20d
> Mar  7 11:28:07 db kernel:  [<c016fd2e>] search_binary_handler+0x75/0x17b
> Mar  7 11:28:07 db kernel:  [<c016ffbd>] do_execve+0x189/0x20a
> Mar  7 11:28:07 db kernel:  [<c01019ea>] sys_execve+0x46/0x90
> Mar  7 11:28:07 db kernel:  [<c0102d75>] syscall_call+0x7/0xb
> Mar  7 11:28:07 db kernel: Code: 54 24 3c 39 90 54 04 00 00 0f 84 50 09 00 00 e8 40 33 fd ff 85 c0 89 c3 0f 88 11 05 00 00 8b 8c 24 a0 00 00 00 8b 81 0c 01 00 00 <f0> ff 40 14 8b 91 0c 01 00 00 89 d8 89 5c 24 50 31 ff e8 20 34
>
[snip]

If this is reproducible could you please try 2.6.16-rc5-git10 and/or
2.6.16-rc5-mm2 and send the Oops report from those kernels please?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
