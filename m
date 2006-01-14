Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWANOLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWANOLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWANOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:11:45 -0500
Received: from soundwarez.org ([217.160.171.123]:18314 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751448AbWANOLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:11:44 -0500
Date: Sat, 14 Jan 2006 15:11:35 +0100
From: Kay Sievers <kay.sievers@suse.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Greg K-H <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] INPUT: add MODALIAS to the event environment
Message-ID: <20060114141135.GA12581@vrfy.org>
References: <11371818082670@kroah.com> <11371818084013@kroah.com> <43C88898.10900@ums.usu.ru> <20060114110401.GA11237@vrfy.org> <43C8F962.9030409@ums.usu.ru> <20060114132138.GA12273@vrfy.org> <43C8FFD7.3030408@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C8FFD7.3030408@ums.usu.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 06:42:47PM +0500, Alexander E. Patrakov wrote:
> Kay Sievers wrote:
> >On Sat, Jan 14, 2006 at 06:15:14PM +0500, Alexander E. Patrakov wrote:
> >
> >>i.e., there is the "modalias" file in sysfs but no $MODALIAS in the 
> >>environment. Is this the problem that your patch solves (note: I haven't 
> >>tried it yet)?
> >
> >Well, you could have read the mail's subject, before posting.
> >
> Indeed, sorry.
> 
> I have applied your patch on top of gregkh-all-2.6.15.patch and changed 
> my module-loading udev rule to:
> 
> ENV{MODALIAS}=="?*",    RUN+="/sbin/modprobe $env{MODALIAS}"
> 
> Now this works and loads modules for my PS/2 mouse. Thanks for the patch.

Great, thanks for testing it. Do you have any subsystem left, that could
support modalias, but doesn't?

Thanks,
Kay
