Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbTHZTDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTHZTDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:03:39 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:49110 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262843AbTHZTDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:03:36 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Steven Cole <elenstev@mesatop.com>
To: Oleg Drokin <green@namesys.com>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1061922037.1670.3.camel@spc9.esa.lanl.gov>
References: <20030826102233.GA14647@namesys.com>
	 <1061922037.1670.3.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1061923101.1670.9.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 26 Aug 2003 12:38:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 12:20, Steven Cole wrote:
> On Tue, 2003-08-26 at 04:22, Oleg Drokin wrote:
> > Hello!
> > 
> >    I have just released another reiser4 snapshot that I hope all interested
> >    parties will try. It is released against 2.6.0-test4.
> >    You can find it at http://namesys.com/snapshots/2003.08.26
> >    I include release notes below.
> > 
> > Reiser4 snapshot for 2003.08.26
> > 
> 
> I got this error while attempting to compile with reiser4.
> Snippet from .config follows.
> 
> Steven
> 
>   CC      fs/reiser4/plugin/file/tail_conversion.o
>   CC      fs/reiser4/sys_reiser4.o
> fs/reiser4/sys_reiser4.c:54:32: parser/parser.code.c: No such file or directory
[snipped]
> [steven@spc1 linux-2.6.0-test4-r4]$ grep REISER4 .config
> CONFIG_REISER4_FS=y
> CONFIG_REISER4_FS_SYSCALL=y

I should have read this more carefully :(

config REISER4_FS_SYSCALL
        bool "Enable reiser4 system call"
        depends on REISER4_FS
        default n
        ---help---
      Adds sys_reiser4() syscall.
      This code is not in good shape yet and may not compile and stuff like that.

Without REISER4_FS_SYSCALL, -test4 with reiser4 compiles fine.  Sorry about the noise.

Steven


