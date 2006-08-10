Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWHJUwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWHJUwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWHJUwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:52:55 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14982 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932129AbWHJUwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:52:53 -0400
Message-ID: <44DB9CA1.2050306@garzik.org>
Date: Thu, 10 Aug 2006 16:52:49 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain>	<20060809233914.35ab8792.akpm@osdl.org>	<44DB61D7.1000109@us.ibm.com>	<20060810111839.51c73911.akpm@osdl.org>	<44DB9582.6010609@garzik.org> <20060810133338.8d1f6061.akpm@osdl.org>
In-Reply-To: <20060810133338.8d1f6061.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 10 Aug 2006 16:22:26 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> I strongly disagree that ext3 should be subject to a spring cleaning. 
>> Comments, whitespace, very very minor things, sure.  Trying to get rid 
>> of brelse() when _many_ other filesystems also use it?  ext4 material.
> 
> We should seek to minimise the difficulty of cross-porting bugfixes and
> enhancements.  Putting cleanups in only ext4 works against that.
> 
> ext3 will be around for many years yet.  We cannot just let it rot due to
> some false belief that performing routine maintenance against it will for
> some magical reason cause it to break.

Because ext4 is impending, you want to push a bunch of cleanups into 
ext3 over a short span of time.  That's not routine maintenance at all. 
  We're not talking about routine maintenance.  In your words, we are 
talking about spring cleaning.

Why not let the devel/stable system work its magic?  If the cleanups are 
viable, proving that first in ext4 should give us more confidence to put 
them into ext3.

Cross-porting bugfixes and cleanups will _obviously_ be quite easy, 
during the first few months of ext4's life.

Just look at ext2->ext3 history.  Regardless of when you make the split, 
there will be a bunch of stuff people wish to backport after the split 
occurs.  Given that, it makes more sense to testbed the changes in ext4 
first.

	Jeff


