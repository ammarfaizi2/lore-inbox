Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274902AbTHPTHg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 15:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274903AbTHPTHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 15:07:36 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:19973 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S274902AbTHPTHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 15:07:35 -0400
Subject: Re: 2.6.0-test3-mm2 kernel BUG at mm/filemap.c:1930
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Josh McKinney <forming@charter.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20030816180923.GA6332@charter.net>
References: <20030816180923.GA6332@charter.net>
Content-Type: text/plain
Message-Id: <1061060852.581.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 16 Aug 2003 21:07:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-16 at 20:09, Josh McKinney wrote:
> Got this while trying to mount the rootfs.  It was ext3 if that makes
> any diff.  
> 
> ksymoops 2.4.8 on i686 2.6.0-test3-mm1.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.6.0-test3-mm1/ (default)
>      -m /usr/src/2.5/linux-2.6.0-test2/System.map (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> <4>kernel BUG at mm/filemap.c:1930!

Please, edit mm/filemap.c and remove the line #1390. It's a BUG_ON()
macro that is complete harmless. Once you have removed that line,
recompile the kernel.

