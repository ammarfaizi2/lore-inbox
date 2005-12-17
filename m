Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVLQVej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVLQVej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVLQVej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:34:39 -0500
Received: from lame.durables.org ([64.81.244.120]:19644 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S964947AbVLQVei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:34:38 -0500
Subject: Re: [PATCH 04/13]  [RFC] ipath LLD core, part 1
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217123838.7732c201.akpm@osdl.org>
References: <200512161548.lRw6KI369ooIXS9o@cisco.com>
	 <200512161548.20XjmmxDHjOZRXcz@cisco.com>
	 <20051217123838.7732c201.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 13:34:36 -0800
Message-Id: <1134855276.20575.25.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 12:38 -0800, Andrew Morton wrote:
> Roland Dreier <rolandd@cisco.com> wrote:
> >
> > +	if ((ret = copy_from_user(&rpkt, p, sizeof rpkt))) {
> > +		_IPATH_DBG("Failed to copy in pkt struct (%d)\n", ret);
> > +		return ret;
> > +	}
> 
> The driver does this quite a lot.  copy_from_user() will return the number
> of bytes remaining to copy.  So I think we'll be wanting `return -EFAULT;'
> in lots of places rather than this.

Thanks.  Will fix.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


