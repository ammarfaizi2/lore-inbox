Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTFDRMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTFDRMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:12:20 -0400
Received: from ds4.granbury.com ([205.162.53.20]:36623 "EHLO ds4.granbury.com")
	by vger.kernel.org with ESMTP id S263610AbTFDRMT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:12:19 -0400
From: "Jeremy Salch" <salch@tblx.net>
To: "'Stewart Smith'" <stewart@linux.org.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Access past end of device
Date: Wed, 4 Jun 2003 12:23:50 -0500
Message-ID: <002001c32abe$10a18700$9fdeae3f@TBLXM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030604170215.GA9732@cancer>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a fdisk on the device /dev/sda  and it found no bad blocks.  

I was given the suggestion from one person it sounds like a kernel bug since
redhat patches their kernels soo much.


-----Original Message-----
From: Stewart Smith [mailto:stewart@linux.org.au] 
Sent: Wednesday, June 04, 2003 12:02 PM
To: Jeremy Salch
Cc: linux-kernel@vger.kernel.org
Subject: Re: Access past end of device


On Wed, Jun 04, 2003 at 11:13:02AM -0500, Jeremy Salch wrote:
> I'm using a dell powerall web 120 with scsi drives installed Using 
> redhat 7.2 with the 2.4.18-19.7.x kernel installed
> 
> Attempt to access beyond end of device
> 08:06: rw=0, want=1044196, limit=1044193
> 1044192
> Pass completed, 1 bad blocks found.
> And fdisk reports there to be 1044193+ blocks in the partition ?

Sounds like the partition map is a bit incorrect.

Try running badblocks on the drive itself (/dev/hda, not hda1). If the
problem disappears then it's with the partition map (i'd guess).

- stew

