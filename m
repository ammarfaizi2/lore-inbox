Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTJaPfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 10:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTJaPfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 10:35:38 -0500
Received: from [62.38.229.37] ([62.38.229.37]:6061 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S263370AbTJaPfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 10:35:32 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Mike Houston <mikeserv@bmts.com>
Subject: Re: 2.6.0-test9 breaks cdrecord w. ide-scsi device
Date: Fri, 31 Oct 2003 17:35:44 +0200
User-Agent: KMail/1.5.3
References: <200310310012.47580.p_christ@hol.gr> <20031030171432.03dcaa76.mikeserv@bmts.com>
In-Reply-To: <20031030171432.03dcaa76.mikeserv@bmts.com>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310311735.45859.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello
>
> I don't really know what the problem with ide-scsi is (I'm not much of a
> programmer) but is there any particular reason you're clinging to the old
> ide-scsi method for CD writing? This has been broken a few times now in the
> 2.5/2.6 tree. Even when it is working, it's still somewhat broken and they
> know it. I have found that the maximum speed I can get is 16x using
> ide-scsi in the 2.6 tree.
>
> There is now ide-cd writing support, and cdrecord 2 supports it. I build
> that stuff modular, so I just load the ide-cd and isofs modules (modprobe
> takes care of the rest). I achieve the fastest writing speeds I've ever
> had, using this driver. Far better than ide-scsi or even Sleazy CD Creator
> in Windows.
>
> In the cdrecord command, everything is the same except you use
> dev=/dev/hdxx instead of the dev=x,x,x scsi target notation. For example:
>
> cdrecord -v speed=48 dev=/dev/hdd -data filename.iso
>
> Just in case you didn't know this or have never tried this. I hope it helps
> you.
>
It's true that I hadn't tried the native ATAPI method lately.
My point, however, was that there is a regression from -test8 to -test9 about 
cdrecord-ing.

