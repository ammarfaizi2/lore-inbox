Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbUJ0OuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbUJ0OuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUJ0OuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:50:11 -0400
Received: from [195.23.16.24] ([195.23.16.24]:37514 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262468AbUJ0Ot4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:49:56 -0400
Message-ID: <417FB590.4000500@grupopie.com>
Date: Wed, 27 Oct 2004 15:49:52 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guven Demir <guven.demir@gmail.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question: how to invalidate read cache
References: <6cb735e904102707181e58d208@mail.gmail.com>
In-Reply-To: <6cb735e904102707181e58d208@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.11; VDF: 6.28.0.39; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guven Demir wrote:
> hi all,
> 
> i hope this is the right place to ask question... anyway, it goes like this:
> 
> how can i invalidate the read cache for a file system?
> 
> the reason i'm asking this question is:
> 
> i'm mounting this ntfs partition to my linux box r/o, which i also
> used by "another os" running under vmware r/w.
> 
> so when this partition gets updated under vmware, linux does not get
> the changes until i umount / mount the partition again.
> 
> the problem is, i cant do this when the partiton is busy so i'm stuck
> with invalid directory entries etc...
> 
> so, is there a way to disable or invalidate the read cache for this partition?

As a basic rule, never mount the same block device from two OS's (even 
if they are the same model).

Even if you could "disable" read cache from the Linux side, what makes 
you think that the "other OS" (or even vmware) isn't doing some write 
caching that will ruin it for you?

If you want a "shared space" between the 2 OS'es I would suggest you 
share at a higher level, like a sharing a directory on the "other OS" 
and mount it using samba on Linux through a virtual network card (or the 
other way around).

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
