Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318805AbSIPFIy>; Mon, 16 Sep 2002 01:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318807AbSIPFIy>; Mon, 16 Sep 2002 01:08:54 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:59112 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S318805AbSIPFIy>; Mon, 16 Sep 2002 01:08:54 -0400
Date: Sun, 15 Sep 2002 22:30:04 -0700
From: Matt Porter <porter@cox.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] add vmalloc stats to meminfo
Message-ID: <20020915223004.A17831@home.com>
References: <3D8422BB.5070104@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D8422BB.5070104@us.ibm.com>; from haveblue@us.ibm.com on Sat, Sep 14, 2002 at 11:03:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2002 at 11:03:39PM -0700, Dave Hansen wrote:
> Some workloads like to eat up a lot of vmalloc space.  It is often hard to tell
> whether this is because the area is too small, or just too fragmented.  This 
> makes it easy to determine.

Great, I was going to do something nearly the same to help out
with debugging high-end embedded applications.  It is quite common
for us to see multiple PCI masters with PCI memory windows in sizes
ranging from 256MB-1GB that are being ioremapped and consuming
vmalloc space (along with all the other consumers).  I'd love to
see this in the kernel since it would make it much easier to debug
some folks' custom board ports when they show symptoms of running
out of vmalloc space (i.e. modules not loading).

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
