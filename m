Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317612AbSFMNzu>; Thu, 13 Jun 2002 09:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317613AbSFMNzt>; Thu, 13 Jun 2002 09:55:49 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:60112 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317612AbSFMNzs>; Thu, 13 Jun 2002 09:55:48 -0400
Date: Thu, 13 Jun 2002 15:55:45 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: write-permission check for root
In-Reply-To: <Pine.LNX.3.95.1020613085331.1340A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.05.10206131549500.15690-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dick,

> > i was wondering if if it's reasonable to disable root write access
> > for procfs,driverfs files (which have file permissions set to read
> > only)
> 
> It is never reasonable. Check what root can do with any file...

yes, for the normal filesystem it's reasonable - procfs and driverfs
are a different thing. (if you want everyone just to read the value,
you mean everyone - even root)

procfs _does_ implement a check for that, it's only driverfs which doesn't
(for now) ... and i just wanted to know if there's a reason for that.

--snip/snip

> The ability for root to do anything, including ignoring file-permissions,
> is not going to go away.

it is gone already. (try to change /proc/version ;), also the capabilities
are there to not allow _everything_ for root (but that's not neccesarily an
fs issue)

thanks,

	tm

-- 
in some way i do, and in some way i don't.

