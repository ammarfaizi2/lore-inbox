Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbUDDXer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 19:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUDDXer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 19:34:47 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:22149 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262924AbUDDXep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 19:34:45 -0400
Subject: Re: 2.6.5-rc3-mm4
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <32948.192.168.0.250.1081041322.squirrel@192.168.0.250>
References: <32948.192.168.0.250.1081041322.squirrel@192.168.0.250>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1081121682.2585.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Apr 2004 19:34:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-03 at 20:15, Paul Blazejowski wrote:
> Under kernel 2.6.5-rc3-mm4 i get a nice oops when trying to see the
> contents of NFS export from BSD box.The NFS share gets mounted and shows:
> 
> blazebox:/usr/home/paul on /mnt/nfs type nfs (rw,addr=192.168.0.1)
> 
> but any attempt to browse using ls or nautilus etc... gets seg faulted.
> 
> dmesg:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000002
>  printing eip:
> 43bdb08f
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<43bdb08f>]    Tainted: P   VLI
> EFLAGS: 00010206   (2.6.5-rc3-mm4)
> EIP is at nfs3_decode_dirent+0xf/0x250 [nfs]

If it hadn't been for Andrew sending me a copy this mail would have gone
straight to /dev/null. Please ensure that you label NFS-related mails
with a clear "NFS" in the subject header if you want me to notice them.
Nobody has enough free time on their hands to spend reading all 1000
LKML emails each day.

Mind sending me a binary tcpdump of that readdir? Please use something
like
  tcpdump -s 9000 -w dump.out port 2049 and host insert_name_of_server

Cheers,
  Trond
