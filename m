Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130693AbRCMAFk>; Mon, 12 Mar 2001 19:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130702AbRCMAFa>; Mon, 12 Mar 2001 19:05:30 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:54077 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130698AbRCMAF2>;
	Mon, 12 Mar 2001 19:05:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Oops in 2.4.2 - please give advice 
In-Reply-To: Your message of "Mon, 12 Mar 2001 18:36:33 BST."
             <B45465FD9C23D21193E90000F8D0F3DF683A35@mailsrv.linkvest.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Mar 2001 11:04:54 +1100
Message-ID: <15015.984441894@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001 18:36:33 +0100, 
Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com> wrote:
>Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
>c02086c0, System.map says c014f200.  Ignoring ksyms_base entry

That message is suspicious.  It looks like you have md built into the
kernel but some module has redefined partition_name.  Since the only
code that defines partition_name in 2.4.2 is drivers/md/md.c, it looks
like you managed to build md.o into the kernel and as a module.  Please
double check your config and modules_install.

