Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280104AbRKVRVU>; Thu, 22 Nov 2001 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280114AbRKVRVJ>; Thu, 22 Nov 2001 12:21:09 -0500
Received: from codepoet.org ([166.70.14.212]:9590 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280104AbRKVRU5>;
	Thu, 22 Nov 2001 12:20:57 -0500
Date: Thu, 22 Nov 2001 10:20:54 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix SCSI non-blocksize reads
Message-ID: <20011122102054.A11961@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011122014131.A16981@codepoet.org> <Pine.LNX.4.33.0111220908010.1383-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111220908010.1383-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 22, 2001 at 09:09:23AM -0800, Linus Torvalds wrote:
> 
> On Thu, 22 Nov 2001, Erik Andersen wrote:
> >
> > Several SCSI drivers blindly do reads of size 1024 when trying to read
> > the partition table.   This fails on Magneto Optical drives and similar
> > odd devices with 2048 byte native sector sizes.  This patch fixes that
> > so I can have partitions on my MO drive again (it lives on an Adaptec
> > card at present and has 2048 byte sectors),
> 
> Please use the "block_size()" function instead of doing it by hand..

Ok.  I just did it the same way most of the other SCSI drivers
do this...

Would you like a patch that also fixes all the other SCSI drivers 
to use block_size() then, so they will be consistent?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
