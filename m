Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSIEArQ>; Wed, 4 Sep 2002 20:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSIEArQ>; Wed, 4 Sep 2002 20:47:16 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:41487 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316569AbSIEArP>;
	Wed, 4 Sep 2002 20:47:15 -0400
Date: Wed, 4 Sep 2002 17:49:51 -0700
From: Greg KH <greg@kroah.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.33 : drivers/hotplug/cpqphp_core.c error
Message-ID: <20020905004951.GC8947@kroah.com>
References: <Pine.LNX.4.44.0209011755040.25625-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209011755040.25625-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 05:56:32PM -0400, Frank Davis wrote:
> Hello all,
>   While a 'make modules', I received the following error.
> 
> Regards,
> Frank
> 
> In file included from cpqphp_core.c:40:
> cpqphp.h: In function `cpq_get_latch_status':

<snip>

This is due to the __FUNCTION__ usages in this driver.  But this driver
has been broken for a while, so I've now fixed this problem, and am
working on the core functional problems.  I should have a new version in
a few days.

Do you have a machine that you use this driver on, that you would be
willing to help test any changes on?

thanks,

greg k-h
