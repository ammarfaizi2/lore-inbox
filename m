Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTFDQuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 12:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTFDQuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 12:50:14 -0400
Received: from mail009.syd.optusnet.com.au ([210.49.20.137]:48611 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263587AbTFDQuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 12:50:13 -0400
Date: Thu, 5 Jun 2003 03:02:15 +1000
To: Jeremy Salch <salch@tblx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Access past end of device
Message-ID: <20030604170215.GA9732@cancer>
References: <001d01c32ab4$2cb8e320$9fdeae3f@TBLXM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c32ab4$2cb8e320$9fdeae3f@TBLXM>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 11:13:02AM -0500, Jeremy Salch wrote:
> I'm using a dell powerall web 120 with scsi drives installed
> Using redhat 7.2 with the 2.4.18-19.7.x kernel installed 
> 
> Attempt to access beyond end of device
> 08:06: rw=0, want=1044196, limit=1044193
> 1044192
> Pass completed, 1 bad blocks found.
> And fdisk reports there to be 1044193+ blocks in the partition ?

Sounds like the partition map is a bit incorrect.

Try running badblocks on the drive itself (/dev/hda, not hda1).
If the problem disappears then it's with the partition map (i'd guess).

- stew

