Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTFVJWB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 05:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTFVJWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 05:22:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9988 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264368AbTFVJWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 05:22:00 -0400
Date: Sun, 22 Jun 2003 02:36:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Samuel.Thibault@ens-lyon.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit big console scrolls
Message-Id: <20030622023626.60d2a24e.akpm@digeo.com>
In-Reply-To: <Pine.GSO.4.21.0306221102430.869-100000@vervain.sonytel.be>
References: <200306210621.h5L6LbUo011422@hera.kernel.org>
	<Pine.GSO.4.21.0306221102430.869-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 09:36:04.0575 (UTC) FILETIME=[B34FD6F0:01C338A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > -			if (get_user(lines, (char *)arg+1)) {
>  						    ^^^^^
>  > +			if (get_user(lines, (s32 *)((char *)arg+4))) {
>  							    ^^^^^
>  >  				ret = -EFAULT;
>  >  			} else {
>  >  				scrollfront(lines);
> 
>  Why was the `arg+1' changed to `arg+4'? Do we really want to skip 12 bytes?

It skips three bytes?
