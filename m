Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWHTR53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWHTR53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWHTR53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:57:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29081 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751110AbWHTR52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:57:28 -0400
Subject: Re: [Patch] Signdness issue in drivers/scsi/osst.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, osst@riede.org
In-Reply-To: <1156015188.19657.7.camel@alice>
References: <1156015188.19657.7.camel@alice>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:18:37 +0100
Message-Id: <1156097917.4051.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-19 am 21:19 +0200, ysgrifennodd Eric Sesterhenn:
> Hi,
> 
> another signdness warning from gcc 4.1
> 
> drivers/scsi/osst.c:5154: warning: comparison of unsigned expression < 0 is always false
> 
> The problem is that blk is defined as unsigned, but all usages of it
> are normal int cases. osst_get_frame_position() and osst_get_sector()
> return ints and can return negative values. If blk stays an unsigned int,
> the error check is useless.


Acked-by: Alan Cox <alan@redhat.com>

