Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264167AbTEOTAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTEOTAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:00:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2977 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264167AbTEOTAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:00:09 -0400
Date: Thu, 15 May 2003 12:09:23 -0700
From: Greg KH <greg@kroah.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: duncan.sands@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
Message-ID: <20030515190922.GA10161@kroah.com>
References: <20030515052041.GA5995@kroah.com> <200305151432.h4FEW5Gi012599@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305151432.h4FEW5Gi012599@locutus.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 10:32:05AM -0400, chas williams wrote:
> In message <20030515052041.GA5995@kroah.com>,Greg KH writes:
> >It's not really bothering me, just wondering when it will go away (I see
> >it when building one of the USB ATM drivers...)
> 
> the MOD_* functions in the speedtch driver don't need to be there.  
> since 2.3.something (if i remember correctly) the reference counting
> has been handled by the upper layer (ala fops_get/fops_put).  the
> following patch removes these extra bits:

Thanks, didn't know they could be removed.  The speedtch author told me
a while ago that the fops didn't protect it...

I'll go apply this patch.

thanks,

greg k-h
