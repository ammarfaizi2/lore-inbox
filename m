Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWECTMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWECTMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 15:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWECTMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 15:12:53 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:24971 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750729AbWECTMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 15:12:52 -0400
Date: Wed, 3 May 2006 21:12:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?ISO-8859-15?Q?Markus_M=FCller?= <mm@priv.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
In-Reply-To: <4458F407.9050101@priv.de>
Message-ID: <Pine.LNX.4.61.0605032108470.9829@yvahk01.tjqt.qr>
References: <4458C48B.8040703@priv.de> <20060503215635.4b3a28bf.vsu@altlinux.ru>
 <4458F407.9050101@priv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ... and you have only 512 MB with no swap.  Try to add some swap space -
>> then reiserfsck might eventually complete.
>> 
>> AFAIK, the only way to recover reiserfs after --rebuild-tree has been
>> attempted is to run "reiserfsck --rebuild-tree" to completion.
>> 
> ok, you say that you think/know it is normal that reiserfsck needs more
> than 512 MB ram... I just thought this is a bug. :-)
>
> So I try with 1 GB real ram and another 1 GB of swap. You're sure
> everything is normal, and we don't have a problem at all?

A 1.5TB reiserfs3 volume takes long to mount. That's because it build the 
some bitmaps at mount time. Which means it (the kernel fs) requires more 
ram as your partitions grow. I only have one blurry experience value which 
is approximately 128MB per 1.9TB. Then you also need RAM for fsck...
Note that fsck'ing ext* filesystems also take their time, even when the 
filesystem is otherwise clean (e.g. mount count reached).


Jan Engelhardt
-- 
