Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVASRPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVASRPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVASRPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:15:12 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:9186 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261786AbVASROx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:14:53 -0500
Date: Wed, 19 Jan 2005 09:13:23 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119171323.GB14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119094342.GB25623@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050119 01:44]:
>
> > 
> > Please note that this patch alone does not help much with
> > power savings. More work is needed in that area to make the
> > system take advantage of the idle time inbetween the skipped
> > ticks.
> 
> Well, having HZ=100 instead of HZ=1000 has measurable benefits on
> power consumption. This should be at least as good, no?

HZ=100 does not allow improving the idle loop much further
from what we have. We should be able to take advantage of the
longer idle/sleep periods inbetween the skipped ticks.

Tony
