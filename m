Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVCWHJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVCWHJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbVCWHJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:09:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:53416 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262836AbVCWHJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:09:07 -0500
Date: Wed, 23 Mar 2005 08:08:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Invalidating dentries
In-Reply-To: <20050322184452.2408be4b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503230808000.21578@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503211626180.20464@yvahk01.tjqt.qr>
 <20050322184452.2408be4b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> how can I invalidate all buffered/cached dentries so that ls -l /somefolder 
>>  will definitely go read the harddisk?
>
>Patch the kernel?

Great idea.

>A quick way of doing it would be to add a new mount option to the
>filesystem and call shrink_dcache_sb() from there.  do `mount -o
>remount,shrink_dcache'.

I doubt that there is a way to define an option applicable to all fs?
But thanks for the idea.


Jan Engelhardt
-- 
