Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268945AbTBSRSI>; Wed, 19 Feb 2003 12:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268949AbTBSRSI>; Wed, 19 Feb 2003 12:18:08 -0500
Received: from happy.phnet.fi ([62.165.128.129]:20639 "HELO happy.phnet.fi")
	by vger.kernel.org with SMTP id <S268945AbTBSRSH>;
	Wed, 19 Feb 2003 12:18:07 -0500
Message-ID: <3E53BEA0.8000808@sci.fi>
Date: Wed, 19 Feb 2003 19:28:00 +0200
From: Janne Heikkinen <jamse@sci.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 oopses with OSS/munmap
References: <3E532DE8.1080303@sci.fi>
In-Reply-To: <3E532DE8.1080303@sci.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janne Heikkinen wrote:

> When trying to to use mmap with OSS with kernel version 2.4.20, 
> program causes oops
> when munmapping takes place (either when calling munmap directly or 
> when program is
> terminating).  

I looked into it more carefully and most of the time I don't actually 
get oops but system
just goes unstable. It is allways second time when program is run when 
this hang with
munmap() happens.

Program that causes this maps DMA buffer with mmap, uses SNDCTL_DSP_GETIPTR
ioctl() after select()  and then copies data from mmap'd buffer into 
another buffer. Everything
goes fine until munmap().

It seems to be exactly the same problem that Paul Forgey had run into 
and wrote
about in January with subject "oss bug introduced since 2.4.18?".

Janne Heikkinen

