Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279867AbRJ3Eta>; Mon, 29 Oct 2001 23:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279861AbRJ3EtU>; Mon, 29 Oct 2001 23:49:20 -0500
Received: from [63.231.122.81] ([63.231.122.81]:11312 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279853AbRJ3EtF>;
	Mon, 29 Oct 2001 23:49:05 -0500
Date: Mon, 29 Oct 2001 21:49:18 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
Message-ID: <20011029214918.A27370@lynx.no>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011029163920.F806@lynx.no> <Pine.LNX.4.30.0110291814100.30096-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110291814100.30096-100000@waste.org>; from oxymoron@waste.org on Mon, Oct 29, 2001 at 06:23:31PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2001  18:23 -0600, Oliver Xymoron wrote:
> Backport to 2.2 might be a good idea too..

Note that the 2.2 kernel code is (AFAIK) quite different from the 2.4
kernel code for drivers/char/random.c.  The serious bug - not incrementing
"in" was introduced in 2.3.16.  The other real bug - trunctating the pool
entropy to the number of words in the pool, does not exist in 2.2.  It
correctly compares it agains POOLBITS.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

