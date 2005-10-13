Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVJMKLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVJMKLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJMKLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 06:11:45 -0400
Received: from mail.shareable.org ([81.29.64.88]:42722 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1750851AbVJMKLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 06:11:44 -0400
Date: Thu, 13 Oct 2005 11:11:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Janak Desai <janak@us.ibm.com>
Cc: chrisw@osdl.org, viro@ZenIV.linux.org.uk, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] New System call unshare (try 2)
Message-ID: <20051013101137.GA22049@mail.shareable.org>
References: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janak Desai wrote:
> +
> +/*
> + * Performs sanity checks on the flags passed to the unshare system
> + * call.
> + */
> +static inline int check_unshare_flags(unsigned long unshare_flags)

After making the changes we talked about to the above function - it
would make sense for clone() to call it too.  Have the tests in one
place, so both calls are consistent with each other, and will remain
so.  The atomic_read() parts are dependent on the call being
unshare(), but the bit tests should be identical I think.

-- Jamie
