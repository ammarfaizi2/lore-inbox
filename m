Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWCVWSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWCVWSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWCVWSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:18:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17336
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932126AbWCVWSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:18:00 -0500
Date: Wed, 22 Mar 2006 14:17:39 -0800
From: Greg KH <gregkh@suse.de>
To: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/23] Kobject: provide better warning messages when people do stupid things
Message-ID: <20060322221739.GC13453@suse.de>
References: <11428920383371-git-send-email-gregkh@suse.de> <442034FE.1010006@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442034FE.1010006@oktetlabs.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 08:16:46PM +0300, Artem B. Bityutskiy wrote:
> Greg Kroah-Hartman wrote:
> >+
> >+		/* be noisy on error issues */
> >+		if (error == -EEXIST)
> >+			printk("kobject_add failed for %s with -EEXIST, "
> >+			       "don't try to register things with the "
> >+			       "same name in the same directory.\n",
> >+			       kobject_name(kobj));
> 
> This looks like an attempt to put documentation into kernel code. Isn't 
>  it better to add good documentation to the header file just above the 
> prototype?

Normally I would agree with you, but it's users that hit this error,
when they load a combination of drivers that no developer has in the
past.  And due to the noise in my inbox, people are still quite confused
when this happens.  That error message is to help people determine what
the real problem is.

> When I started using sysfs, I noticed a lack of good comments above 
> prototypes of exported functions.

I agree, care to provide a patch that fixes this?

thanks,

greg k-h
