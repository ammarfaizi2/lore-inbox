Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVILUIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVILUIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVILUIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:08:06 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:30941 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932186AbVILUIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:08:05 -0400
Date: Tue, 13 Sep 2005 00:07:33 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Olaf Hering <olh@suse.de>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.13: Crash in Yenta initialization
Message-ID: <20050913000733.A14261@jurassic.park.msu.ru>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <200509030245.12610.koch@esa.informatik.tu-darmstadt.de> <20050903223401.A7470@jurassic.park.msu.ru> <20050912174209.GA3965@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050912174209.GA3965@suse.de>; from olh@suse.de on Mon, Sep 12, 2005 at 07:42:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 07:42:09PM +0200, Olaf Hering wrote:
> Did you find the reason for this already?

Unfortunately, no.

> We have a similar report:
> https://bugzilla.novell.com/show_bug.cgi?id=113778
> ...
> It dies in yenta_config_init because dev->subordinate is NULL.  
> ...

Yes, this looks identical to Andreas' report.

Perhaps adding the line

#define DEBUG 1

at the very top of drivers/pci/probe.c could help to catch something
interesting in dmesg.

Ivan.
