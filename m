Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312606AbSDAVSx>; Mon, 1 Apr 2002 16:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312608AbSDAVSo>; Mon, 1 Apr 2002 16:18:44 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:21235 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312606AbSDAVSi>; Mon, 1 Apr 2002 16:18:38 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 1 Apr 2002 14:17:13 -0700
To: "James E. Hitzroth" <jhitzrot@digisle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 compile errors w/ Compaq DL360 Smart2 controller
Message-ID: <20020401211713.GD3067@turbolinux.com>
Mail-Followup-To: "James E. Hitzroth" <jhitzrot@digisle.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1017718659.1216.63.camel@jhitzcompaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 01, 2002  19:37 -0800, James E. Hitzroth wrote:
> File drivers/block/smart1,2.h
> 
> line 256  needs 'c' comment 
> 
>     242 static unsigned long smart1_completed(ctlr_info_t *h)
      :
      :
>     254 
>     255 
>     256 # error Please convert me to Documentation/DMA-mapping.txt

No, actually "#error" is a C pre-processor directive to cause the
compiler to generate an error at that spot (#warning generates a
compiler warning).

This was obviously put there by someone because this driver needs to be
updated to match a change in an API in the 2.5 kernel.  Making it a
comment means that either you will get a compile error anyways, but
without the useful pointer as to how it can be fixed, or worse - no
compile error but problems (including data corruption) later on.

I would do as the message states, and read DMA-mapping.txt to fix this.
Quite often kernel developers do not have access to all of the hardware
supported by Linux, so it is up to people like yourself who _do_ have
this hardware to fix it and test it - it is in your own best interest
to do so.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

