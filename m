Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUIQQMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUIQQMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUIQQLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:11:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13481 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269012AbUIQQFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:05:03 -0400
Date: Fri, 17 Sep 2004 09:04:48 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, zaitcev@redhat.com
Subject: Re: [BUG] ub.c badness in current bk
Message-Id: <20040917090448.32ff763c@lembas.zaitcev.lan>
In-Reply-To: <1095414394.13531.77.camel@gaston>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
	<20040917002935.77620d1d@lembas.zaitcev.lan>
	<1095414394.13531.77.camel@gaston>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 19:46:34 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Ok, here's a modified patch that fixes the problem for me.

> +	ret = sc->changed;
> +	/* P3 */ printk("%s: %s changed\n", sc->name, ret ? "is": "was not");
> +	
> +	sc->changed = 0;
>  	return sc->changed;
>  }

You return zero always. I don't think it's supposed to be that way.
I'm sorry, but I cannot apply it. I'll look for a better solution.

-- Pete
