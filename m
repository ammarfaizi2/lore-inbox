Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVCDUd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVCDUd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbVCDUXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:23:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263045AbVCDURy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:17:54 -0500
Date: Fri, 4 Mar 2005 12:17:40 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Patch to enable the USB handoff on Dell 650
Message-ID: <20050304121740.07a3af47@localhost.localdomain>
In-Reply-To: <20050202071847.GA786@pazke>
References: <20050201100241.07c6c504@localhost.localdomain>
	<20050202071847.GA786@pazke>
X-Mailer: Sylpheed-Claws 1.0.1cvs20.1 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 10:18:47 +0300 Andrey Panin <pazke@donpac.ru> wrote:

> > +++ linux-2.6.11-rc2-lem/arch/i386/kernel/dmi_scan.c	2005-01-31 20:42:16.163592792 -0800

> > +static __init int enable_usb_handoff(struct dmi_blacklist *d)
> > +{

> Please don't add new quirks into dmi_scan.c. Use dmi_check_system()
> where possible.

Do you have a suggestion for a good place where to add a suitable
call for dmi_check_system for the USB handoff? Please observe that
it does not belong with the USB code, in fact we have this code
there already. It has to happen before any device drivers are
initiated.

-- Pete
