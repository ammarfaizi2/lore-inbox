Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281090AbRKOVm3>; Thu, 15 Nov 2001 16:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281084AbRKOVmT>; Thu, 15 Nov 2001 16:42:19 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:4103 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281083AbRKOVmE>;
	Thu, 15 Nov 2001 16:42:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: ksymoops and initrd (was kiobuf / vm bug) 
In-Reply-To: Your message of "Thu, 15 Nov 2001 17:55:31 BST."
             <20011115175531.A7068@bytesex.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Nov 2001 08:41:53 +1100
Message-ID: <14522.1005860513@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2001 17:55:31 +0100, 
Gerd Knorr <kraxel@bytesex.org> wrote:
>ksymoops 2.4.3 on i686 2.4.15-pre4.  Options used
>Error (expand_objects): cannot stat(/modules/ide-disk.o) for ide-disk
>Error (expand_objects): cannot stat(/modules/ide-probe-mod.o) for ide-probe-mod
>Error (expand_objects): cannot stat(/modules/ide-mod.o) for ide-mod
>Error (expand_objects): cannot stat(/modules/ext2.o) for ext2
>Warning (map_ksym_to_module): cannot match loaded module ext2 to a unique module object.  Trace may not be reliable.

You are using ksymoops to decode an oops from a system booted with
modules in initrd.  The module pathnames in initrd do not match the
pathnames for the on disk modules which causes those warning messages.
When decoding an oops from an initrd boot, use 'ksymoops -i'.

