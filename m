Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965316AbWH2Uq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965316AbWH2Uq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWH2Uq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:46:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965312AbWH2Uqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:46:55 -0400
Date: Tue, 29 Aug 2006 13:46:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH -mm] PM: Add pm_trace switch
Message-Id: <20060829134648.451971a1.akpm@osdl.org>
In-Reply-To: <200608291309.57404.rjw@sisk.pl>
References: <200608291309.57404.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 13:09:57 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +int pm_trace_enabled;
> +
> +static ssize_t pm_trace_show(struct subsystem * subsys, char * buf)
> +{
> +	return sprintf(buf, "%d\n", pm_trace_enabled);
> +}
> +
> +static ssize_t
> +pm_trace_store(struct subsystem * subsys, const char * buf, size_t n)
> +{
> +	int val;
> +
> +	if (sscanf(buf, "%d", &val) == 1) {
> +		pm_trace_enabled = !!val;
> +		return n;
> +	}
> +	return -EINVAL;
> +}
> +
> +power_attr(pm_trace);

<grumbles about documentation>
