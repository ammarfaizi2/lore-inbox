Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280799AbRKBTJg>; Fri, 2 Nov 2001 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280791AbRKBTJ2>; Fri, 2 Nov 2001 14:09:28 -0500
Received: from [63.231.122.81] ([63.231.122.81]:39490 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280799AbRKBTEE>;
	Fri, 2 Nov 2001 14:04:04 -0500
Date: Fri, 2 Nov 2001 12:03:25 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Russ Weight <rweight@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bdevname(), cdevname(), kdevname() - static buffers
Message-ID: <20011102120325.K746@lynx.no>
Mail-Followup-To: Russ Weight <rweight@us.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011102104211.A1279@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011102104211.A1279@us.ibm.com>; from rweight@us.ibm.com on Fri, Nov 02, 2001 at 10:42:11AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 02, 2001  10:42 -0800, Russ Weight wrote:
> I was looking at the usage of bdevname(), cdevname(), and kdevname(),
> and noticed that they each return a pointer to a static buffer.
> This buffer contains a formatted device name, which is typically
> printed immediately following the call. However, I don't see any
> explicit lock protection for these buffers.
> 
> For SMP systems, is there something implicit in their use that
> prevents a race on these buffers? Has anyone seen garbled device
> names being printed (which might be attributed to a race)?

I think the general usage of these is only for informational needs, so
if there is a rare race it is not worth fixing.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

