Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSEKDDN>; Fri, 10 May 2002 23:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316198AbSEKDDM>; Fri, 10 May 2002 23:03:12 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:46854 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314079AbSEKDDM>;
	Fri, 10 May 2002 23:03:12 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: Your message of "Sat, 11 May 2002 02:58:32 +0100."
             <Pine.LNX.4.21.0205110255410.2235-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 13:03:00 +1000
Message-ID: <4058.1021086180@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002 02:58:32 +0100 (BST), 
Hugh Dickins <hugh@veritas.com> wrote:
>Is there some escaped syntax whereby we can (usefully) put
>KBUILD_BASENAME into the BUG() macro in place of __FILE__?

AFAICT without testing it, you should be able to directly replace
__FILE__ with KBUILD_BASENAME.  Both are just pre-processor variables.

On my bells and whistles list (things to add after kbuild 2.5 is in the
kernel) is KBUILD_UNIQUE_NAME.  That variable will contain enough of
the pathname to uniquely identify the source.  For globally unique
names it is the same as KBUILD_BASENAME with a .[cS] suffix.  For
repeated filenames like inode.c it is fs/inode.c for the top level,
ext2/inode.c for an individual filesystem.

