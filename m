Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbRLYSiA>; Tue, 25 Dec 2001 13:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285704AbRLYShu>; Tue, 25 Dec 2001 13:37:50 -0500
Received: from pat.uio.no ([129.240.130.16]:37591 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S285692AbRLYShd>;
	Tue, 25 Dec 2001 13:37:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15400.51047.900520.331948@charged.uio.no>
Date: Tue, 25 Dec 2001 19:37:27 +0100
To: Amber Palekar <amber_palekar@yahoo.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Again:syscall from modules
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com>
In-Reply-To: <shssn9zv43k.fsf@charged.uio.no>
	<20011225131441.60811.qmail@web20306.mail.yahoo.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Amber Palekar <amber_palekar@yahoo.com> writes:

     >  Hi,
 
    >> Just use sock_sendmsg() and sock_recvmsg() directly.  They are
    >> both exported in netsyms.c.
     >   Is there any specific reason behind not exporting
     > sys_sendto and sys_recvfrom ??

Why would you want to do that when you already have a better kernel
interface available?

The sys_sendto, sys_recvfrom references the sockets by file handle,
something which requires an extra lookup operation to map the file
handle to socket struct.
OTOH sock_sendmsg(), sock_recvmesg() provides exactly the same
functionality, but takes a pointer to the kernel socket structure as
the argument.

Cheers,
  Trond
