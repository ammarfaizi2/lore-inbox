Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289953AbSAWS3w>; Wed, 23 Jan 2002 13:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289963AbSAWS3m>; Wed, 23 Jan 2002 13:29:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21187 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289953AbSAWS3f>;
	Wed, 23 Jan 2002 13:29:35 -0500
Date: Wed, 23 Jan 2002 13:29:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chuck Campbell <campbell@neosoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: find a file containing a specific sector
In-Reply-To: <20020123120055.A14311@helium.inexs.com>
Message-ID: <Pine.GSO.4.21.0201231324550.17439-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Jan 2002, Chuck Campbell wrote:

> For the last 7 months, I've been getting the following error in 
> /var/log/messages every night during the cron.daily execution.  I've finally
> tracked it down to happening during my tripwire run, and I suspect
> (based on linear time into the run, and sizes of files) the problem file
> lies somwhere in /usr/lib.
> 
> The error message has been identical for months, so I assume I have a bad 
> spot that is not spreading.  I'd like to find the affected file, rename it
> and ignore the problem for a while longer.
> 
> If I know the sector and lbasector, can I determine the inode and/or
> the actual file affected?

find /usr/lib -type f|sed -e 's!.*!cat & >/dev/null || echo &!'|sh

