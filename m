Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266755AbUFRTSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266755AbUFRTSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUFRTNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:13:19 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:3017 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266755AbUFRTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:12:36 -0400
Message-ID: <40D34CB2.10900@opensound.com>
Date: Fri, 18 Jun 2004 13:12:34 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS i86pc; en-US; rv:1.4) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de> <40D32C1D.80309@opensound.com> <20040618190257.GN14915@schnapps.adilger.int>
In-Reply-To: <20040618190257.GN14915@schnapps.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Jun 18, 2004  10:53 -0700, 4Front Technologies wrote:
> 
>>The issue is also SuSE's 2.6.4 kernel added the REGPARM patch which was 
>>only introduced in Linux 2.6.5 for example. Wouldn't it be better if SuSE
>>had shipped their kernel as Linux 2.6.5?. The point is what constitutes a
>>"baseline" Linux kernel?. You can add all your patches but if now the
>>kernel is more in tune with Linux 2.6.7, just call it Linux 2.6.7 - calling
>>it 2.6.5 will break a lot of software that isn't included with your kernel.
> 
> 
> We gave up trying to use kernel versions to determine what features/interface
> to use for a given kernel long ago.  Instead we have configure check for a
> particular interface and use "#ifdef HAVE_foo", not "#if LINUX_KERNEL_VERSION".
> 
> I can understand why SuSE does this - there is no way they can ship the
> "latest" kernel and still have tested it thoroughly, yet if they find a
> specific defect they need to fix it (preferrably in the same way that a
> later kernel fixes it).
> 


Andreas,

We precisely use this mechanism - we use 
/lib/modules/<version>/build/include/linux/config.h to figure such features out
but when the "build" part of the path doesn't point to the right source tree,
where do you look?. SuSE ships kernel sources "unconfigured" which means that
you have to rely on something else to tell you what the exact kernel
configuration looks like.

You can look at /proc/config.gz but that's not a standard on all distros either.


best regards

Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------

