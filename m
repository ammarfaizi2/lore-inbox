Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTEUQJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTEUQJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:09:57 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:27892 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262179AbTEUQJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:09:56 -0400
Date: Wed, 21 May 2003 09:25:36 -0700
From: Andrew Morton <akpm@digeo.com>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: re-aim - 2.5.69, -mm6
Message-Id: <20030521092536.1e04edd1.akpm@digeo.com>
In-Reply-To: <200305202021.h4KKLUT32174@mail.osdl.org>
References: <20030520125140.16f5cb46.akpm@digeo.com>
	<200305202021.h4KKLUT32174@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2003 16:22:57.0836 (UTC) FILETIME=[3D87D6C0:01C31FB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
> The two runs are done like this -> (4 cpu machine)
>  ./reaim -s4 -x -t -i4 -f workfile.new_dbase -r3 -b -lstp.config -> for the 
>  maxjobs convergence
>  ./reaim -s4 -q -t -i4 -f workfile.new_dbase -r3 -b -lstp.config -> for the 
>  'quick' convergence
> 
>  stp.config has the poolsizes and path for disk directories:
>  FILESIZE 80k
>  POOLSIZE 1024k
>  DISKDIR /mnt/disk1
>  DISKDIR /mnt/disk2
>  DISKDIR /mnt/disk3
>  DISKDIR /mnt/disk4

Well I spent a few hours running this on the quad xeon (aic7xxx).

There were no hangs, and there was no appreciable performance difference
between 2.5.69, 2.6.69-mm7++ with AS and 2.5.69-mm7++ with deadline.

Please confirm that the hang only happened with the anticipatory scheduler?

It could require a particular device driver to reproduce.  Please see if
you can generate that sysrq-T output.  Also if you can try a different
device driver sometime that would be interesting.  There seem to be several
alternate ISP drivers around - the feral driver perhaps, and the new one in
the linux-scsi tree.

