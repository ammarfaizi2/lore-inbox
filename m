Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269347AbUJKXgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269347AbUJKXgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJKXgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:36:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:42714 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269347AbUJKXf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:35:58 -0400
Date: Mon, 11 Oct 2004 16:35:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andre Tomt <andre@tomt.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
In-Reply-To: <1097522974.2029.161.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0410111633410.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
 <416A53D3.9020002@tomt.ne t>  <Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org>
 <1097507381.2029.40.camel@mulgrave>  <416ACF5E.80407@tomt.net>
 <1097522974.2029.161.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, James Bottomley wrote:
> 
> Yes, well, that's one of the things that worries me slightly ... no-one
> has reported the data corruption that the patch claims to fix.  That's
> one of the reasons I was planning to take it through the normal cycle.

Well, as far as I can tell from the patch, the only way to get data 
corruption from the bug is when you use the SCSI ioctl's at the same time 
as the disk is busy.

In other words, I think you'd have to do some special disk management, or
possibly try to burn a CD on a SCSI CD-ROM (or other special device that
uses the SCSI ioctl's) on the same controller. And nobody uses SCSI
CD-burners any more, I'd think.

		Linus
