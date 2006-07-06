Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWGFHoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWGFHoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 03:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWGFHoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 03:44:16 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:31699 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964975AbWGFHoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 03:44:16 -0400
Date: Thu, 6 Jul 2006 09:42:44 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] audit syscall classes
Message-ID: <20060706074244.GA9416@osiris.boeblingen.de.ibm.com>
References: <200607011800.k61I02nV022260@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607011800.k61I02nV022260@hera.kernel.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 06:00:02PM +0000, Linux Kernel Mailing List wrote:
> commit b915543b46a2aa599fdd2169e51bcfd88812a12b
> tree 8025e6654829d4c245b5b6b6f47a84543ebffb7b
> parent 6e5a2d1d32596850a0ebf7fb3e54c0d69901dabd
> author Al Viro <viro@zeniv.linux.org.uk> Sat, 01 Jul 2006 11:56:16 -0400
> committer Al Viro <viro@zeniv.linux.org.uk> Sat, 01 Jul 2006 15:44:10 -0400
> 
> [PATCH] audit syscall classes
> 
> Allow to tie upper bits of syscall bitmap in audit rules to kernel-defined
> sets of syscalls.  Infrastructure, a couple of classes (with 32bit counterparts
> for biarch targets) and actual tie-in on i386, amd64 and ia64.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
>  arch/i386/kernel/Makefile               |    1 
>  arch/i386/kernel/audit.c                |   23 ++++++++++++++++++
>  arch/ia64/ia32/Makefile                 |    1 
>  arch/ia64/ia32/audit.c                  |   11 +++++++++
>  arch/ia64/kernel/Makefile               |    1 
>  arch/ia64/kernel/audit.c                |   29 +++++++++++++++++++++++
>  arch/x86_64/ia32/Makefile               |    3 ++
>  arch/x86_64/ia32/audit.c                |   11 +++++++++
>  arch/x86_64/kernel/Makefile             |    1 
>  arch/x86_64/kernel/audit.c              |   29 +++++++++++++++++++++++
>  include/asm-generic/audit_change_attr.h |   18 ++++++++++++++
>  include/asm-generic/audit_dir_write.h   |   14 +++++++++++
>  include/linux/audit.h                   |    7 +++++
>  kernel/auditfilter.c                    |   39 ++++++++++++++++++++++++++++++++
>  14 files changed, 188 insertions(+)

Excuse my ignorance, but this looks like every architecture needs to add
something like this. If it is needed, is there some easy way to test the
implementation?
