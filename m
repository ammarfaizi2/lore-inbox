Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWECRar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWECRar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 13:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWECRar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 13:30:47 -0400
Received: from hermes.domdv.de ([193.102.202.1]:41998 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1030261AbWECRaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 13:30:46 -0400
Message-ID: <4458E8C4.3060902@domdv.de>
Date: Wed, 03 May 2006 19:30:44 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_M=FCller?= <mm@priv.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
References: <4458C48B.8040703@priv.de> <Pine.LNX.4.61.0605031842260.13546@yvahk01.tjqt.qr> <4458E619.8090501@priv.de>
In-Reply-To: <4458E619.8090501@priv.de>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Müller wrote:
> no, the hdd is a software raid 5, /dev/md0, which is piped through aes
> via cryptsetup, so it is accessed via /dev/mapper/hdb

My experience with such a stacking and reiserfs was horrible. Continous
filesystem corruption that finally required reformatting. I then
replaced reiserfs with ext3 and the stacking works since then.

It is not a dm-crypt problem as the symptoms also occurred with
raid5/lvm2/reiserfs, so any raidx/dm/reiserfs stacking seems to be only
something for the more adventurous folks. Thus I don't know if the
problem still exists with current kernels.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
