Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVBPVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVBPVwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVBPVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:52:35 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:18205 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262099AbVBPVw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:52:28 -0500
To: "govind raj" <agovinda04@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
X-Message-Flag: Warning: May contain useful information
References: <BAY10-F340B43C6A61C2D47ECC913D66C0@phx.gbl>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 16 Feb 2005 13:52:26 -0800
In-Reply-To: <BAY10-F340B43C6A61C2D47ECC913D66C0@phx.gbl> (govind raj's
 message of "Thu, 17 Feb 2005 03:17:56 +0530")
Message-ID: <52r7jgw4th.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Feb 2005 21:52:26.0567 (UTC) FILETIME=[CDBF8D70:01C51471]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    govind> Thanks for all the pointers.  We had taken the /sbin/init
    govind> from the existing Linux installation from where we had
    govind> created the customized image. We need to have a inittab
    govind> and we believe that we have set it correctly. The GRUB
    govind> detects the CF hard disk as hda0 when we boot the embedded
    govind> board and so in both the kernel parameter in grub.conf as
    govind> well as in the inittab file we have / (root) marked as
    govind> /dev/hda0. But we are perplexed by the message that the
    govind> kernel prints out on being booted from the flash and just
    govind> before panic'ing...

Using /dev/hda0 as root seems a little strange to me, as the usual way
of naming partitions starts with 1 (so the first partition would be
/dev/hda1).  However the kernel seems to be finding and starting your
init executable, so that likely isn't your problem.

I would suggest starting by using a statically linked shell as your init
and building up from there.

 - Roland
