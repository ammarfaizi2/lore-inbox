Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVADCIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVADCIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVADCIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:08:11 -0500
Received: from dp.samba.org ([66.70.73.150]:21926 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261960AbVADCHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:07:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.63978.65838.823252@samba.org>
Date: Tue, 4 Jan 2005 13:05:30 +1100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <41D9F65E.3030301@zytor.com>
References: <41D9C635.1090703@zytor.com>
	<16857.56805.501880.446082@samba.org>
	<41D9E3AA.5050903@zytor.com>
	<16857.59946.683684.231658@samba.org>
	<41D9EDF6.1060600@zytor.com>
	<16857.62250.259275.305392@samba.org>
	<41D9F65E.3030301@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Right, but here we're talking about exposing the guts of a DOS-based 
 > filesystem so they can be manipulated by an application which isn't 
 > necessarily a bulk file handler.  The API doesn't really work for that, 
 > especially since some of the attributes have different access properties 
 > from the others.

right. Samba doesn't care much about VFAT, and you don't care about
all the other attributes, so we should get along fine without treading
on each others toes too much.

I explained what Samba4 does as you asked about the user.DosAttrib
xattr that Steve put a placeholder for in cifsfs. That came from
Samba4, so if you suddenly started using it in a different way I would
get a sore toe :-)

Once the Samba LSM module is done and Wine and Samba start working
more together on all these extra bits of meta-data then we could
consider making your ioctl work on all filesystems when the LSM module
is loaded.

Cheers, Tridge
