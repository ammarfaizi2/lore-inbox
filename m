Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRJZSCF>; Fri, 26 Oct 2001 14:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278818AbRJZSBv>; Fri, 26 Oct 2001 14:01:51 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:41737 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278815AbRJZSBm>;
	Fri, 26 Oct 2001 14:01:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sebastian Heidl <heidl@zib.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild-2.5-2.4.11-pre5-1 on 2.4.13 -- failure 
In-Reply-To: Your message of "Fri, 26 Oct 2001 16:55:31 +0200."
             <20011026165531.R19509@csr-pc1.zib.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Oct 2001 04:02:07 +1000
Message-ID: <10033.1004119327@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2001 16:55:31 +0200, 
Sebastian Heidl <heidl@zib.de> wrote:
>Rereading input trees to get new config timestamps
>  phase 2 (evaluate selections)
>pp_makefile2: Cannot find source for target fs/ext2/acl.o
>make: *** [/usr/src/kernel/linux-2.4.13/.tmp_targets] Error 1

fs/ext/acl.c has been deleted since 2.4.11-pre5, fs/ext/Makefile.in is
for 2.4.11-pre5 so it still refers to acl.o.  To use a kbuild 2.5 patch
against a newer kernel you have to identify all Makefile changes since
the kernel that kbuild 2.5 was issued against and make the
corresponding changes to the Makefile.in files.

