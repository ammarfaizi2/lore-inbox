Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUJ3UAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUJ3UAd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 16:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUJ3UAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 16:00:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:3213 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261295AbUJ3UAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 16:00:06 -0400
Date: Sat, 30 Oct 2004 12:57:07 -0700
From: Greg KH <greg@kroah.com>
To: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-bk8: hotplug breakage
Message-ID: <20041030195707.GA14308@kroah.com>
References: <20041030194647.GA5585@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030194647.GA5585@linuxtv.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 09:46:47PM +0200, Johannes Stezenbach wrote:
> Hi Greg,
> 
> this patch:
> 
> http://linux.bkbits.net:8080/linux-2.6/diffs/lib/kobject_uevent.c@1.10
> 
> broke hotplug (the firmware loader in my case),
> because the SEQNUM env var will now overwrite an
> env var added by hotplug_ops->hotplug() (e.g. FIRMWARE).

Known bug, see the thread "[Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c
buffer issues" for more details and a fix for it.

thanks,

greg k-h
