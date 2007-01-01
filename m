Return-Path: <linux-kernel-owner+w=401wt.eu-S1755201AbXAAOPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbXAAOPx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 09:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbXAAOPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 09:15:53 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:53775 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201AbXAAOPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 09:15:52 -0500
X-Greylist: delayed 1118 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jan 2007 09:15:52 EST
Date: Mon, 1 Jan 2007 14:57:18 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Freezer.h updated patch.
Message-ID: <20070101135718.GA19125@aepfle.de>
References: <1161519286.3512.12.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1161519286.3512.12.camel@nigel.suspend2.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, Nigel Cunningham wrote:

> +++ b/drivers/macintosh/via-pmu.c

> -#include <linux/suspend.h>
> +#include <linux/freezer.h>

This change will lead to compile errors with -Wimplicit-function-declaration.
What part of freezer.h is used in via-pmu.c?

drivers/macintosh/via-pmu.c:2014: warning: implicit declaration of function `pm_prepare_console'
drivers/macintosh/via-pmu.c:2139: warning: implicit declaration of function `pm_restore_console'

