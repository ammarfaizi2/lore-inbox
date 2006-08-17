Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWHQBSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWHQBSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 21:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWHQBSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 21:18:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:46480 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932351AbWHQBSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 21:18:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gaCJaK42DWeGH6sknlC/9BkdQf3Y+DUWMMNCvJVt2SBMwaTdVTTIMYeh4XpccsEaPx7ADhGbHGHtmee3IOhzd4vZL3iGzNcCSVlDAINwC7YZHlcl4ULkkXRPlsICkz7G5rSmovDTLSgxECY+2Z2ckwa8q0rqSjizMr/ZNGVZXyE=
Message-ID: <625fc13d0608161818n102b1571t1c0b967a530589ef@mail.gmail.com>
Date: Wed, 16 Aug 2006 20:18:32 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Haavard Skinnemoen" <hskinnemoen@atmel.com>
Subject: Re: [PATCH] MTD: Add lock/unlock operations for Atmel AT49BV6416
Cc: "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060809110607.244db551@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
	 <1154680114836-git-send-email-hskinnemoen@atmel.com>
	 <1154680873.31031.182.camel@shinybook.infradead.org>
	 <20060809110607.244db551@cad-250-152.norway.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> On Fri, 04 Aug 2006 16:41:12 +0800
> David Woodhouse <dwmw2@infradead.org> wrote:
>
> > On Fri, 2006-08-04 at 10:28 +0200, Haavard Skinnemoen wrote:
> > > What's the best way to do this? Unlock the flash in the
> > > board-specific mapping driver perhaps?
> >
> > That's what we used to do. If more people are emulating the Intel
> > brain damage and having chips which render the lock operation entirely
> > pointless by locking the chips at every power cycle, then I suppose we
> > ought to consider making auto-unlock a function of the chip type.
>
> It appears that Atmel has reverted this in later chips, like the
> AT49BV642D. Updated patch below, if you still want it. Please disregard
> the jedec_probe patch as I've got AT49BV6416 working in CFI mode now.
>
> This patch depends on "MTD: Convert Atmel PRI information to AMD
> format" which I just submitted, as it needs the definition
> of CFI_MFR_ATMEL.

I've added this patch to my tree.

josh
