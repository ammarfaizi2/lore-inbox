Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVFCAOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVFCAOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 20:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFCAOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 20:14:22 -0400
Received: from fog.sekrit.org ([66.92.77.184]:59615 "EHLO fog.sekrit.org")
	by vger.kernel.org with ESMTP id S261451AbVFCAOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 20:14:20 -0400
Date: Thu, 2 Jun 2005 20:14:19 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing monotonic clock from modules
Message-ID: <20050603001419.GA15686@fog.sekrit.org>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 08:36:48AM +0200, Mikael Starvik wrote:
> We would like to get the posix monotonic clock from a loadable module.
> Would a patch to make do_posix_clock_monotonic_gettime exported ok or
> should we do it in some other way?

A possible use of a clean api would be in the packet rx timestamping code
where one is interested in accurate inter-packet timing, but the only way of
timestamping currently uses do_gettimeofday, so is fragile across time
time changes.

				-- Gerald
