Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRCPNHM>; Fri, 16 Mar 2001 08:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCPNHB>; Fri, 16 Mar 2001 08:07:01 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:19205 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129112AbRCPNGv>;
	Fri, 16 Mar 2001 08:06:51 -0500
Date: Fri, 16 Mar 2001 14:05:58 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1
Message-ID: <20010316140558.A1805@pcep-jamie.cern.ch>
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU> <Pine.GSO.4.21.0103152146550.10709-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0103152146550.10709-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Mar 15, 2001 at 10:11:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 	* verify_area() cleans the value, but you'll be better off
> considering these as dangerous - it only checks that range is OK and if
> pointer arithmetics moves you out of that range or you access piece longer
> than range in question...

Note that verify_area's argument cannot be safely dereferenced if a
parallel thread is able to change the user-space mapping.  This is
usually possible.

-- Jamie
