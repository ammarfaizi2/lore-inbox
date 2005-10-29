Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVJ2UHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVJ2UHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbVJ2UHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:07:36 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:27147 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932806AbVJ2UHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:07:33 -0400
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, 333776@bugs.debian.org
Subject: Re: Bug#333776: linux-2.6: vfat driver in 2.6.12 is not properly case-insensitive
References: <20051013165529.GA2472@tennyson.dodds.net>
	<20051028082252.GC11045@verge.net.au>
	<874q71wv2b.fsf@devron.myhome.or.jp>
	<200510291645.08872.ioe-lkml@rameria.de>
	<87k6fwcmp0.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.64.0510291941020.5182@hermes-1.csi.cam.ac.uk>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 30 Oct 2005 05:07:05 +0900
In-Reply-To: <Pine.LNX.4.64.0510291941020.5182@hermes-1.csi.cam.ac.uk> (Anton Altaparmakov's message of "Sat, 29 Oct 2005 19:44:20 +0100 (BST)")
Message-ID: <87fyqkcck6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> writes:

>> Probably, yes. I think we need to know on-disk filename's code set.
>
> If FAT stores the filenames in 8 bits (non-UTF) then yes, it will be in 
> the current locale/code page of the Windows system writing them (e.g. that 
> happens with the names of EAs in NTFS).
>
> If the names are stored in 16-bit Unicode like on NTFS then obviously they 
> are completely locale/code page independent.  (Makes my life in NTFS a 
> _lot_ easier.  Especially since the NTFS volume contains an upcase table 
> for the full 16-bit Unicode which we load and use to do upcasing for the 
> case insensitive comparisons...)

Yes, I got to know it from fs/ntfs/*. :)  Unfortunately, FAT stores
8/16bits codeset filename always. (Unicode (UCS2?) is stored in only
case of longname.)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
