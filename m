Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVDUUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVDUUM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVDUUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:12:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:32685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261848AbVDUUM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:12:58 -0400
Date: Thu, 21 Apr 2005 13:12:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Andy Isaacson <adi@hexapodia.org>, Troy Benjegerdes <hozer@hozed.org>,
       Bernhard Fischer <blist@aon.at>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050421201227.GI23013@shell0.pdx.osdl.net>
References: <20050421173821.GA13312@hexapodia.org> <4267F367.3090508@ammasso.com> <20050421195641.GB13312@hexapodia.org> <4268080E.3000303@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4268080E.3000303@ammasso.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Timur Tabi (timur.tabi@ammasso.com) wrote:
> Andy Isaacson wrote:
> >Do you guys simply raise RLIMIT_MEMLOCK to allow apps to lock their
> >pages?  Or are you doing something more nasty?
> 
> A little more nasty.  I raise RLIMIT_MEMLOCK in the driver to "unlimited" 
> and also set cap_raise(IPC_LOCK).  I do this because I need to support all 
> 2.4 and 2.6 kernel versions with the same driver, but only 2.6.10 and later 
> have any support for non-root mlock().

FYI, that will not work on all 2.6 kernels.  Specifically anything that's
not using capabilities.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
