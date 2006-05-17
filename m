Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWEQM5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWEQM5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWEQM5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:57:41 -0400
Received: from mx1.suse.de ([195.135.220.2]:60118 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750792AbWEQM5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:57:40 -0400
Date: Wed, 17 May 2006 14:57:39 +0200
From: Olaf Hering <olh@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
Message-ID: <20060517125739.GA24438@suse.de>
References: <20060517081314.GA20415@suse.de> <1147871055.10470.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1147871055.10470.9.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, May 17, Alan Cox wrote:

> On Mer, 2006-05-17 at 10:13 +0200, Olaf Hering wrote:
> > dmesg will look like this:
> >  sda: [AIX]  unknown partition table
> > 
> 
> You should check for the overlapping partitions as well. The label
> itself may be left over if someone repartitions an ex-AIX disk. Simply
> adding this test is going to give one or two people a nasty "where has
> my data gone" kind of shock.

Maybe, but since that code is in fdisk since ages, and its also in
parted since ages and noone complained about the early bail there, it
surely cant be a problem.
Also, there is likely the mbr code usually in the first few bytes.

> Having said that perhaps the IBM people can provide proper information
> on how to detect/parse the AIX partition data ?

How would that help if you have no filesystem driver?
