Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbVGNJsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVGNJsz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVGNJsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:48:54 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44223 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262990AbVGNJsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:48:54 -0400
Date: Thu, 14 Jul 2005 11:48:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fuse chardevice number
In-Reply-To: <E1Dsyhe-0005A9-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.61.0507141145181.18072@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507132213450.23970@yvahk01.tjqt.qr>
 <E1Dsyhe-0005A9-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>  /** The minor number of the fuse character device */
>> -#define FUSE_MINOR 229
>> +#define FUSE_MINOR MISC_DYNAMIC_MINOR
>
>FUSE has an allocated fix minor.  Dynamic minor is much harder to
>handle with legacy /dev (not udev).

How many users of 2.6.13 and up really do not have/run udev? [Please don't 
send too many responses]

A module option could be added to specify an explicit minor.


Jan Engelhardt
-- 
