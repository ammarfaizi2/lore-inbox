Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbTGJLR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbTGJLR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:17:58 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:42512 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S269210AbTGJLR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:17:57 -0400
Date: Thu, 10 Jul 2003 15:32:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tavis Ormandy <taviso@gentoo.org>
Cc: linux-kernel@vger.kernel.org, alpha@gentoo.org
Subject: Re: [PATCH] 2.4.21: Optionally Configure UAC Policy via Sysctl (Alpha)
Message-ID: <20030710153217.A21944@jurassic.park.msu.ru>
References: <20030710081513.GA7671@sdf.lonestar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030710081513.GA7671@sdf.lonestar.org>; from taviso@gentoo.org on Thu, Jul 10, 2003 at 08:15:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 08:15:13AM +0000, Tavis Ormandy wrote:
> +  To disable the warning messages at runtime, you might use
> +
> +  echo 1 > /proc/sys/kernel/uac/noprint

It's really bad idea. Unaligned traps are *bugs*, so we don't
want to hide them. Especially system-wide.

You can do all the same per process, using existing OSF-compatible
UAC control.

Ivan.
