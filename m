Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbUKMWp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbUKMWp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUKMWp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:45:26 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:34689 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261192AbUKMWpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:45:23 -0500
Date: Sat, 13 Nov 2004 23:44:45 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Stelian Pop <stelian@popies.net>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] drivers/net/pcmcia: use module_param() instead of MODULE_PARM()
Message-ID: <20041113224444.GA6926@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Stelian Pop <stelian@popies.net>, "Randy.Dunlap" <rddunlap@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041104112736.GT3472@crusoe.alcove-fr> <418AE490.1010304@pobox.com> <20041110155903.GA8542@sd291.sivit.org> <20041110160058.GB8542@sd291.sivit.org> <41924339.1070809@osdl.org> <20041110195200.GJ2706@deep-space-9.dsnet> <41927055.9030306@osdl.org> <20041110212132.GK2706@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110212132.GK2706@deep-space-9.dsnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 10:21:32PM +0100, Stelian Pop wrote:
> If module parameters are a memory issue

module paramters, independent of exporting into sysfs [and they're not
free'd on init!] need 56 bytes per module, and 20 + sizeof(name of
parameter) bytes per module parameter.

If they're exported to sysfs, the first one per module costs 66, all other
ones 10 bytes. So exporting to sysfs is cheap.

	Dominik
