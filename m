Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUHIPj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUHIPj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUHIPgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:36:46 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28617 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266163AbUHIPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:35:36 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mj@ucw.cz
In-Reply-To: <200408091158.i79BwhPj009609@burner.fokus.fraunhofer.de>
References: <200408091158.i79BwhPj009609@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092061969.14150.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 15:32:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 12:58, Joerg Schilling wrote:
> >From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> >BTW while I remember cdrecord has a bug with hardcoded iso8859-1
> >copyright symbols in it which mean your copyright banner is invalid
> >unicode on a UTF-8 locale.
> 
> 
> It seems that you like to write unproven and thus wrong things :-(

export LC_ALL=cy_GB.UTF-8
run cdrecord 
review the output. Its using a hardcoded 8859-1/15 symbols so it breaks.

> BTW: this also appears to your comments on the Solaris device handling....
> Did you ever install Solaris 10 and test?

I've seen it on older Solaris. When drives walk between scsi busses as
the system is running it doesn't like it

