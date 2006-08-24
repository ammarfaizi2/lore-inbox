Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWHXTQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWHXTQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWHXTQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:16:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38084 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750760AbWHXTQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:16:23 -0400
Date: Thu, 24 Aug 2006 14:16:11 -0500
From: "Serge E. Hallyn" <sergeh@us.ibm.com>
To: David Safford <safford@watson.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Serge E Hallyn <sergeh@us.ibm.com>,
       kjhall@us.ibm.com, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060824191611.GB1625@sergelap.austin.ibm.com>
References: <1156359937.6720.66.camel@localhost.localdomain> <20060823192733.GG28594@kvack.org> <1156365357.6720.87.camel@localhost.localdomain> <1156418815.3007.89.camel@localhost.localdomain> <20060824133248.GC15680@sergelap.austin.ibm.com> <1156428917.3007.150.camel@localhost.localdomain> <20060824152322.GD32764@sergelap.austin.ibm.com> <1156439113.3007.170.camel@localhost.localdomain> <1156440849.2476.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156440849.2476.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Safford (safford@watson.ibm.com):
> On Thu, 2006-08-24 at 18:05 +0100, Alan Cox wrote:
> > It is a matter of the timing and the device. You need to do revocation
> > at the device level because your security state change must occur after
> > the devices have all been dealt with. This is why I said you need the
> > core of revoke() to do this.
> 
> In a typical system, most applications are started at the correct level,
> and we don't have to demote/promote them. In those cases where demotion
> or promotion are needed, only a small number actually already have
> access that needs to be revoked. Of those, most involve shmem, which
> I believe we are revoking safely, as we don't have the same problems
> with drivers and incomplete I/O. In the remaining cases, where we really
> can't revoke safely, we could simply not allow the requested access, and
> not demote/promote the process.
> 
> I think this would give us a useful balance of allowing "safe" demotion
> or promotions, while not requiring general revocation. Does this sound
> like a reasonable approach?

It sounds like you're saying "This should not be a problem unless the
system is being abused/exploited so let's not worry about it."

Assuming that wasn't your intent :), could you please rephrase?

thanks,
-serge


