Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVBKRgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVBKRgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVBKRfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:35:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42909 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262304AbVBKRby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:31:54 -0500
Date: Fri, 11 Feb 2005 17:31:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath
Message-ID: <20050211173143.GA11278@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050211171506.GX10195@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211171506.GX10195@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include "dm.h"
> +#include "dm-path-selector.h"
> +#include "dm-bio-list.h"
> +#include "dm-bio-record.h"
> +
> +#include <linux/ctype.h>
> +#include <linux/init.h>
> +#include <linux/mempool.h>
> +#include <linux/module.h>
> +#include <linux/pagemap.h>
> +#include <linux/slab.h>
> +#include <linux/time.h>
> +#include <linux/workqueue.h>
> +#include <asm/atomic.h>

Always include private headers after public ones.

> +MODULE_DESCRIPTION(DM_NAME " multipath target");
> +MODULE_AUTHOR("Sistina Software <dm-devel@redhat.com>");

Isn't this Red Hat now?

> +#ifndef	DM_MPATH_H
> +#define	DM_MPATH_H
> +
> +#include <linux/device-mapper.h>

no needed, a forward-declaration for struct dm_dev is enough.

> +EXPORT_SYMBOL(dm_register_path_selector);
> +EXPORT_SYMBOL(dm_unregister_path_selector);

I though we agreed to only allow GPL'ed path selectors at OSDL?

> +#ifndef	DM_PATH_SELECTOR_H
> +#define	DM_PATH_SELECTOR_H
> +
> +#include <linux/device-mapper.h>

again, doesn't look like it's needed.

