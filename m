Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWBXWC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWBXWC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWBXWCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:02:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61199 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932595AbWBXWCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:02:54 -0500
Date: Wed, 22 Feb 2006 18:54:01 +0000
From: Pavel Machek <pavel@suse.cz>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [15/16]
Message-ID: <20060222185400.GD2633@ucw.cz>
References: <1140793662.6400.738.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140793662.6400.738.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/fs.h>
> +#include <linux/smp_lock.h>
> +
> +#include "../../lm_interface.h"

ugly...

> +{
> +	char *c;
> +	unsigned int jid;
> +	struct nolock_lockspace *nl;
> +
> +	/* If there is a "jid=" in the hostdata, return that jid.
> +	   Otherwise, return zero. */

useful comment of the year 2006....

> +	c = strstr(host_data, "jid=");
> +	if (!c)
> +		jid = 0;
> +	else {
> +		c += 4;
> +		sscanf(c, "%u", &jid);
> +	}
> +

...
> +
> +static int nolock_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
> +			   lm_lock_t **lockp)
> +{
> +	*lockp = (lm_lock_t *)lockspace;


typedef abuse?

-- 
Thanks, Sharp!
