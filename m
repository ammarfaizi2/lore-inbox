Return-Path: <linux-kernel-owner+w=401wt.eu-S1751722AbWLOX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWLOX0R (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbWLOX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:26:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:42269 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbWLOX0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:26:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=k4NfB6CEphI//LOEn/4Br8C/rmDozCMaITtbMuEMLBwNSiKuvfrYY0RLlzRBWcmvYi+TF39+tEN7v/D1tM5HRF+sXXSAoiyia1k6Keg17F5kn33SmauNZmitwuNgk30F2eRJVqcXb8lW4cORpHKn5uWPDlLYHkNIQA3nPEM6/8c=
Message-ID: <45832F0E.6000005@gmail.com>
Date: Sat, 16 Dec 2006 00:25:43 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Anton Altaparmakov <aia21@cantab.net>
Subject: WARNING (1) at .../arch/i386/mm/highmem.c:49 [Was: 2.6.20-rc1-mm1]
References: <20061214225913.3338f677.akpm@osdl.org>
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Temporarily at
> 
> 	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/
> 
> Will appear later at
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/

Ok, after fixing sata_promise, I got this 7 times:
[   30.957539] WARNING (1) at /home/l/latest/xxx/arch/i386/mm/highmem.c:49
kmap_atomic()
[   30.957642]  [<c0103f1b>] show_trace_log_lvl+0x1a/0x30
[   30.957748]  [<c01045d5>] show_trace+0x12/0x14
[   30.957846]  [<c010465c>] dump_stack+0x16/0x18
[   30.957944]  [<c011a20b>] kmap_atomic+0x1f8/0x20d
[   30.958041]  [<c01b1921>] ntfs_end_buffer_async_read+0x191/0x2ed
[   30.958142]  [<c0182f3a>] end_bio_bh_io_sync+0x26/0x3f
[   30.958241]  [<c01849d4>] bio_endio+0x37/0x62
[   30.958338]  [<c01cc500>] __end_that_request_first+0x224/0x445
[   30.958441]  [<c01cc729>] end_that_request_chunk+0x8/0xa
[   30.958541]  [<c025fe3a>] scsi_end_request+0x1f/0xc6
[   30.958640]  [<c02600c8>] scsi_io_completion+0x1a1/0x336
[   30.958738]  [<c026578d>] sd_rw_intr+0x23/0x1ab
[   30.958835]  [<c025c38d>] scsi_finish_command+0x42/0x47
[   30.958935]  [<c02607f8>] scsi_softirq_done+0x64/0xca
[   30.959032]  [<c01ce2c9>] blk_done_softirq+0x54/0x62
[   30.959132]  [<c0126a25>] __do_softirq+0x75/0xde
[   30.959229]  [<c0126ac9>] do_softirq+0x3b/0x3d
[   30.959326]  [<c0126d5e>] irq_exit+0x3b/0x3e
[   30.959423]  [<c0105746>] do_IRQ+0x45/0x7f
[   30.959540]  [<c010397f>] common_interrupt+0x23/0x28
[   30.959713]  [<c010138b>] cpu_idle+0x7c/0xba
[   30.959809]  [<c01006dc>] rest_init+0x23/0x37
[   30.959951]  [<c050a7df>] start_kernel+0x337/0x3e8
[   30.960090]  [<00000000>] 0x0

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
