Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263052AbTCSPcN>; Wed, 19 Mar 2003 10:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263056AbTCSPcN>; Wed, 19 Mar 2003 10:32:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:10626 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S263052AbTCSPcL>; Wed, 19 Mar 2003 10:32:11 -0500
Message-ID: <3E78927F.4060600@pacbell.net>
Date: Wed, 19 Mar 2003 07:53:35 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg KH <greg@kroah.com>,
       usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.5.65] ehci-hcd, don't use PCI MWI
References: <3E788B06.4090302@pacbell.net> <20030319153421.GA26181@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Wed, Mar 19, 2003 at 07:21:42AM -0800, David Brownell wrote:
> 
>>Hi,
>>
>>Some users have been sending init logs for Athlon kernels that
>>include PCI warning messages about the PCI cache line size
>>getting set incorrectly ... where the kernel thinks that the
>>right value is 16 bytes.  Since 64 bytes is the right number,
>>it's dangerous to enable MWI on such systems.
>>
>>This patch stops trying to use MWI; it's a workaround for the
>>misbehavior of that PCI cacheline-setting code.  Please apply
>>to 2.5 and 2.4 trees.
> 
> 
> Please don't -- Ivan has a patch for this, let's get that in instead.

I'd be happy with that, except on the 2.4 trees where we haven't
seen such a patch yet.  (So Greg -- please hold off on this
for 2.5 unless/until it becomes clear Ivan's patch won't happen.)

> We all acknowledge your patch is a workaround, but this sort of fix does
> not belong in the mainstream kernel.  We want to fix it The Right
> Way(tm), once.  And since a patch already exists for this...

Yep, I figured CC'ing LKML would help move things forward ... :)

- Dave



> We need to get IvanK's extended-save-restore-state patch in, too.
> 
> Ivan, would you be up for a repost on lkml?
> 
> 	Jeff
> 
> 
> 
> 



