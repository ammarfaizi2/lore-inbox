Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWDRKOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWDRKOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWDRKOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:14:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750818AbWDRKOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:14:42 -0400
Date: Tue, 18 Apr 2006 03:13:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, kernel@kolivas.org
Subject: Re: [PATCH -mm] swsusp: rework memory shrinker
Message-Id: <20060418031355.7370b1e6.akpm@osdl.org>
In-Reply-To: <200604181201.53430.rjw@sisk.pl>
References: <200604181201.53430.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Rework the swsusp's memory shrinker in the following way:

And what was the observed effect of all this?

> +		/* Force reclaiming mapped pages in the passes #3 and #4 */
> +		if (pass > 2) {
> +			sc.may_swap = 1;
> +			vm_swappiness = 100;
> +		}

That's a bit klunky.   Maybe we should move swappiness into scan_control.

