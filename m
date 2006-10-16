Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWJPKh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWJPKh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWJPKh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:37:56 -0400
Received: from alpha.polcom.net ([83.143.162.52]:48294 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751490AbWJPKhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:37:55 -0400
Date: Mon, 16 Oct 2006 12:37:48 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to limit VFAT allocation?
In-Reply-To: <4533598A.3040909@dunaweb.hu>
Message-ID: <Pine.LNX.4.63.0610161233400.14187@alpha.polcom.net>
References: <4533598A.3040909@dunaweb.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 16 Oct 2006, Zoltan Boszormenyi wrote:
> I have bought a 2GB MP3 player / flash disk
> that erroneously partitions and formats its storage.
> The built-in firmware has an off-by-one bug that
> creates the partition one cylinder larger that the
> disk size allows and then it formats the VFAT fs
> according to the buggy partition size. No wonder
> when I try to copy large amounts of data to the
> flash disk it detects errors and then remounts it
> read-only.
>
> I tried to repartition and reformat it three times
> with different mformat or mkdosfs options
> but as soon as I remove it from the USB port,
> the device detects changed disk format and
> automatically reformats itself again, so it
> stays buggy.
[snip]
> Unfortunately, the firmware is not upgradeable.
> The device in question is a Telstar UFM-102B.
>
> Is there a way to tell the VFAT driver to exclude
> the last N sectors from the allocation strategy?

Maybe try to setup device mapper linear mapping backed by portion of that 
partition that is ok (== one cylinder smaller) instead of messing with 
filesystem drivers. And then create filesystem on top of that new device.


Grzegorz Kulewski

