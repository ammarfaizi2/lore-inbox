Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUE1N56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUE1N56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUE1N56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:57:58 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:7110 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S263126AbUE1N5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:57:52 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org 
In-reply-to: Your message of "Fri, 28 May 2004 12:10:28 +0100."
             <200405281210.32382.m.watts@eris.qinetiq.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 May 2004 23:57:43 +1000
Message-ID: <8293.1085752663@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004 12:10:28 +0100, 
Mark Watts <m.watts@eris.qinetiq.com> wrote:
>Not aborts, more like this every so often:
>
>
>rsync: connection unexpectedly closed (598189175 bytes read so far)
>rsync error: error in rsync protocol data stream (code 12) at io.c(189)
>rsync: writefd_unbuffered failed to write 4092 bytes: phase "unknown": Broken
>pipe
>rsync error: error in rsync protocol data stream (code 12) at io.c(666)

One end of the link (or somewhere in between) dropped the connection.

>rsync -av --stats --progress --bwlimit=2000 \ 
>rsync://sunsite.uio.no/Mandrakelinux .

For big transfers, always use --partial.  Restarting the transfer will
pick up where it left off.  Also use --delete-after if you use
--delete, so you do not delete old files until all the new files are
down.

