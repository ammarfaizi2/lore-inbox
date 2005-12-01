Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbVLAIWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbVLAIWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbVLAIWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:22:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:3251 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751643AbVLAIWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:22:44 -0500
Message-ID: <438EB2D3.6030605@us.ibm.com>
Date: Thu, 01 Dec 2005 00:22:43 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: Linux Technology Center, IBM
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Chris McDermott <lcm@us.ibm.com>, Luvella McFadden <luvella@us.ibm.com>,
       AJ Johnson <blujuice@us.ibm.com>, Kevin Stansell <kstansel@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
References: <438E90DD.3010007@us.ibm.com> <438E9B24.9020806@pobox.com>
In-Reply-To: <438E9B24.9020806@pobox.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Good, this was the exact response that I was hoping for, as I've been told to
convince Adaptec to drop the binary RAID drivers in favor of helping out dmraid
development instead.  That process will probably be difficult, but at least I
now have incontrovertible proof that nobody will bend over backwards to support
them and that dmraid is the way to go.  Not that I'm terribly surprised by this.

I would, however, like to apologize for all this churlishness.  Hopefully some
day I won't have to deal with these binary modules altogether, and I won't have
to resort to such methods to get vendors to Do the Right Thing(tm).

--D

(A pity that dmraid doesn't do hostraid right now, otherwise none of this would
be necessary.)

Jeff Garzik wrote:

> This is the correct behavior.  Under Linux, the driver should export
> only the underlying hardware, and nothing more.  This is how all the
> SATA controller drivers function, and this is how aic79xx functions.
> 
> Use a tool such as 'dmraid' for vendor-proprietary RAID solutions.
> 
> Your patch is therefore strongly NAK'd.
> 
>     Jeff
