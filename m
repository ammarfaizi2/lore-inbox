Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271358AbTGQJJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271359AbTGQJJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:09:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:34516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271358AbTGQJJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:09:23 -0400
Date: Thu, 17 Jul 2003 02:24:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: zippel@linux-m68k.org, aebr@win.tue.nl, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030717022444.19c204ef.akpm@osdl.org>
In-Reply-To: <20030717091515.GC19891@ca-server1.us.oracle.com>
References: <20030716210253.GD2279@kroah.com>
	<20030716141320.5bd2a8b3.akpm@osdl.org>
	<20030716213451.GA1964@win.tue.nl>
	<20030716143902.4b26be70.akpm@osdl.org>
	<20030716222015.GB1964@win.tue.nl>
	<20030716152143.6ab7d7d3.akpm@osdl.org>
	<20030717014410.A2026@pclin040.win.tue.nl>
	<20030716164917.2a7a46f4.akpm@osdl.org>
	<20030717082716.GA19891@ca-server1.us.oracle.com>
	<Pine.LNX.4.44.0307171037070.717-100000@serv>
	<20030717091515.GC19891@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> 	Well, exporting devices over NFS is always tricky, because if
>  the server isn't an identical OS, you can't even trust the numbers.  As
>  you point out, you get the platform's idea of a device number, and that
>  doesn't map to your local OS.

And surely the task of mangling whatever comes off the wire into a dev_t for
init_special_inode() should be private to the Linux NFS client?

Still wondering why we need to support a 16:16 encoding in [k]dev_t.


