Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVDMBeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVDMBeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVDMBcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:32:02 -0400
Received: from pool-141-154-228-134.bos.east.verizon.net ([141.154.228.134]:62111
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262135AbVDMB2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:28:14 -0400
Date: Tue, 12 Apr 2005 21:23:05 -0400
From: jdike@addtoit.com
To: kos@arhont.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml wouldn't link/compile with UDF
Message-ID: <20050413012305.GA6320@localhost.localdomain>
References: <425C6865.5030306@arhont.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425C6865.5030306@arhont.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 01:31:33AM +0100, Konstantin V. Gavrilenko wrote:
> linux-2.6.11.6.6
> 
> The uml wouldn't compile when the
> CONFIG_UDF_FS=y
> CONFIG_UDF_NLS=y
> 
> The error output is:
> 

> /usr/lib/libc.a(mktime.o)(.rodata+0x0): multiple definition of `__mon_yday'
> fs/built-in.o(.rodata+0x3380): first defined here

A symbol conflict between the kernel and libc.  Not the first, and probably
not the last.  See the errno and sigprocmask flags in UML for a kludge for
this sort of problem.  A real solution is still lacking.

				Jeff

