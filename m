Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUFBKVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUFBKVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUFBKVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:21:06 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:15030 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261530AbUFBKVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:21:04 -0400
Date: Wed, 2 Jun 2004 03:18:42 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: dominik.karall@gmx.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, Markus.Lidel@shadowconnect.com
Subject: Re: 2.6.7-rc2-mm1
Message-Id: <20040602031842.60f48e35.pj@sgi.com>
In-Reply-To: <20040601112418.GM2093@holomorphy.com>
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<200406011248.16303.dominik.karall@gmx.net>
	<20040601112418.GM2093@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 12:48:16PM +0200, Dominik Karall wrote:
>   CC      drivers/scsi/sr_ioctl.o
> drivers/scsi/sr_ioctl.c: In Funktion >>sr_read_cd<<:
> drivers/scsi/sr_ioctl.c:435: error: conflicting types for `cgc'


I ran into the same compile errors in drivers/scsi/sr_ioctl.c.

If I turn off CONFIG_BLK_DEV_SR, then it builds ok.

Just guessing, the problem is likely in the bk-scsi.patch, which seems
to be signed off by James Bottomley, and handled by or originated from
Markus Lidel and various others.  This is the only patch in Andrew's
2.6.7-rc2-mm1 that touches files matching drivers/scsi/sr*.

So I am adding him to the cc list.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
