Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319191AbSH2MKk>; Thu, 29 Aug 2002 08:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319192AbSH2MKk>; Thu, 29 Aug 2002 08:10:40 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:14342 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319191AbSH2MKj>;
	Thu, 29 Aug 2002 08:10:39 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208291214.g7TCEtZ10901@oboe.it.uc3m.es>
Subject: Re: O_DIRECT
In-Reply-To: <200208291113.g7TBDut26852@tench.street-vision.com> from "kernel@street-vision.com"
 at "Aug 29, 2002 11:13:56 am"
To: kernel@street-vision.com
Date: Thu, 29 Aug 2002 14:14:55 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago kernel@street-vision.com wrote:"
> > 
> > What functions does a block driver have to implement in order to
> > support read/write when it has been opened with O_DIRECT from user
> > space.

> Remeber that the memory you read/write from must be page aligned (ie
> mmap /dev/zero not malloc) and reads and writes must be multiples of the
> page size. I think block devices work on 2.4 too, but I forget (otherwise
> you can use raw devices).

I do believe you are right. Multiples of 4096 seem to work fine. No
support needed in the block device driver.

Peter
