Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTENVpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbTENVpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:45:03 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:43757 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262931AbTENVpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:45:02 -0400
Date: Wed, 14 May 2003 14:57:04 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
Message-ID: <20030514215704.GA4232@kroah.com>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil> <20030514205949.GA3945@kroah.com> <20030514.140257.26294164.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514.140257.26294164.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 02:02:57PM -0700, David S. Miller wrote:
>    From: Greg KH <greg@kroah.com>
>    Date: Wed, 14 May 2003 13:59:49 -0700
>    
>    Any reason to not just use a struct device here?  This is a device,
>    right?  Or at the very least, a kobject would be acceptable.
> 
> As I understand it, it's a device private for a struct netdevice.

Ah, thanks.

> It is referenced much differently, I don't think using kobject
> is as appropriate as one might expect.

kobjects are always appropriate! :)

Remember, you don't have to use the sysfs part of a kobject to get the
reference counting and callback when the last reference is dropped
goodness.  A few places in the kernel use them in this manner only,
that's what it was created for.

Ok, if they aren't needed here, I have no problem, just wanted to make
sure.

thanks,

greg k-h
