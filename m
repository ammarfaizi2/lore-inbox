Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUAGKd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266191AbUAGKd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:33:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:21380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266189AbUAGKdX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:33:23 -0500
Date: Wed, 7 Jan 2004 02:33:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: mru@kth.se (=?ISO-8859-1?B?TeVucyBSdWxsZ+VyZA==?=)
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: raid0_make_request bug: can't convert block across chunks or
 bigger than
Message-Id: <20040107023332.5ff0b9ff.akpm@osdl.org>
In-Reply-To: <yw1xznd0ult1.fsf@ford.guide>
References: <yw1xznd0ult1.fsf@ford.guide>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) wrote:
>
> I'm using Linux 2.6.0 on an Alpha SX164 machine.  Using four ATA
>  disks, hd[egik], on a Highpoint hpt374 controller, I created two raid0
>  arrays from hd[eg]1 and hd[ik]1, md0 and md1.  From these, I created a
>  raid1 mirror, md4, on which I created an XFS filesystem.  For various
>  reasons, I first ran md4 with only md0 as a member and filled it with
>  some files, all going well.  Then, I added md1, and it was synced
>  properly.  Now, I can mount md4 without problems.  However, when I
>  read things, I get this in the kernel log:
> 
>  raid0_make_request bug: can't convert block across chunks or bigger than 32k 439200 32

This was fixed post-2.6.0.  2.6.1-rc2 should be OK.

>  raid1: Disk failure on md1, disabling device. 
>  	Operation continuing on 1 devices

I assume this is due to the raid0 error above.
