Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVLGGso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVLGGso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 01:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVLGGso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 01:48:44 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:53263 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030290AbVLGGsn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 01:48:43 -0500
Date: Wed, 7 Dec 2005 07:50:32 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Minor change to platform_device_register_simple
 prototype
Message-Id: <20051207075032.5e968a5a.khali@linux-fr.org>
In-Reply-To: <20051205202707.GH15201@flint.arm.linux.org.uk>
References: <20051205212337.74103b96.khali@linux-fr.org>
	<20051205202707.GH15201@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> On Mon, Dec 05, 2005 at 09:23:37PM +0100, Jean Delvare wrote:
> > The name parameter of platform_device_register_simple should be of
> > type const char * instead of char *, as we simply pass it to
> > platform_device_alloc, where it has type const char *.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> However, I've been wondering whether we want to keep this "simple"
> interface around long-term given that we now have a more flexible
> platform device allocation interface - I don't particularly like
> having superfluous interfaces for folk to get confused with.

What is the new preferred interface? Is it already in mainline or only
in -mm? I am writing a new platform driver, and am using
platform_device_interface_simple for now. It works just fine, but if
it is going to be deprecated soon, I better update my driver before I
submit it for inclusion.

Thanks,
-- 
Jean Delvare
