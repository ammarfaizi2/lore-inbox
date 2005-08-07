Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752410AbVHGRMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbVHGRMt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbVHGRMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:12:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42632 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752410AbVHGRMs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:12:48 -0400
Date: Sun, 7 Aug 2005 10:11:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: John =?ISO-8859-1?B?QuRja3N0cmFuZA==?= <sandos@home.se>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
Message-Id: <20050807101105.711b38e9.akpm@osdl.org>
In-Reply-To: <42F60BE3.6040301@home.se>
References: <42F38B67.5040308@home.se>
	<20050805.093208.74729918.davem@davemloft.net>
	<20050806022435.GB12862@gondor.apana.org.au>
	<20050806075717.GA18104@gondor.apana.org.au>
	<42F60BE3.6040301@home.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bäckstrand <sandos@home.se> wrote:
>
>  Someone asked if I could try to trigger this assertion again, and I'm 
>  afraid I probably cannot, I didnt do anything special at the time. But 
>  I've got something even better for you all, got a BUG from something 
>  tcp-related. Mind you, I am trying to find a possibly hardware-related 
>  issue here, so if this bug does not make any sense it might be my hardware!
> 
>  I would actually want to know it if this is likely hardware-related or 
>  not, since I have no idea if its RAM, CPU, motherboard or "only" a disk 
>  that is broken. I know _something_ is broken, due to lockups, and seeing 
>  a faulty disk indicated in a HDD diag, but only once, the disk is 
>  apparently fine 99% of the time.
> 
>  ---
>  John Bäckstrand
> 
> 
>  [148475.651000] ------------[ cut here ]------------
>  [148475.651050] kernel BUG at net/ipv4/tcp_output.c:918!

I think we've seen a couple of reports of this.

>  [148475.651078] invalid operand: 0000 [#1]
>  [148475.651103] Modules linked in: sha256 aes_i586 dm_crypt ipt_state 
>  ipt_multiport ipt_MASQUERADE iptable_filter netconsole md5 ipv6 
>  af_packet pdc202xx_new e1000 8139cp de2104x i2c_viapro via686a 
>  i2c_sensor i2c_core uhci_hcd usbcore 3c59x 8139too mii de4x5 crc32 
>  parport_pc parport reiserfs dm_mod ip_nat_ftp iptable_nat ip_tables 
>  ip_conntrack_ftp ip_conntrack rtc unix
>  [148475.651378] CPU:    0
>  [148475.651380] EIP:    0060:[<c0286619>]    Not tainted VLI
>  [148475.651383] EFLAGS: 00010287   (2.6.13-rc5sand4)

Can you tell us exactly which kernel this is based on?  If it's 2.6.13-rc5
then it would be better to be testing 2.6.13-rc5-git<latest>, because some
net fixes have been recently merged.

