Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWCaDx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWCaDx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWCaDx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:53:59 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:64516 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750960AbWCaDx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:53:59 -0500
Date: Fri, 31 Mar 2006 05:53:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 16 of 16] ipath - kbuild infrastructure
Message-ID: <20060331035347.GA10420@mars.ravnborg.org>
References: <36bfb4f1ad322a8fb23e.1143674619@chalcedony.internal.keyresearch.com> <adaek0j1w25.fsf@cisco.com> <1143755751.24402.11.camel@chalcedony.internal.keyresearch.com> <ada64lv1rwt.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada64lv1rwt.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 02:36:34PM -0800, Roland Dreier wrote:
>     Bryan> I did ask at one point whether the core driver should live
>     Bryan> in a directory in drivers/char/, since it's not really an
>     Bryan> IB driver at all, and just have the IB-specific stuff live
>     Bryan> in drivers/infiniband/hw/.
> 
> I guess we could do that (now or later).
> 
> For now how about something minimal like the change below?
> 
> Sam, does this seem OK to you?  (The situation is that the IPATH_CORE
> source physically sits in drivers/infiniband/hw/ipath, but it is
> possible to enable IPATH_CORE without enabling INFINIBAND.  So we need
> to tell the build system to descend into drivers/infiniband if
> IPATH_CORE is enabled, even if INFINIBAND isn't enabled)

Hi Roland.
This looks OK. Specifying the same subdirectory twice is no problem.

	Sam
