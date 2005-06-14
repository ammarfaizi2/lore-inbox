Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVFNToU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVFNToU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFNToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:44:20 -0400
Received: from cpe-24-93-204-161.neo.res.rr.com ([24.93.204.161]:36995 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261310AbVFNToR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:44:17 -0400
Date: Tue, 14 Jun 2005 15:40:16 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Message-ID: <20050614194016.GA5351@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	matthieu castet <castet.matthieu@free.fr>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr> <42A46551.9010707@tls.msk.ru> <20050606211855.GA3289@neo.rr.com> <42A4D1AB.3090508@tls.msk.ru> <1118224334.3245.89.camel@localhost.localdomain> <42A75525.3050704@tls.msk.ru> <1118274762.29855.2.camel@localhost.localdomain> <42A8AFA5.3090703@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A8AFA5.3090703@tls.msk.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 01:07:49AM +0400, Michael Tokarev wrote:

> 
> First of all, why disable the device on module unload?
> If it was enabled initially, before any module has been
> loaded, why it needs to be disabled, why not leave it
> enabled and all, just like it has been before?

The original idea here was to free up resources for allocation
to other devices.  The ACPI spec claims we should call _DIS
when powering down the device to _D3.  So, I'm considering not
disabling the device when the driver is unbound, especially with
PNPACPI.  I need to think about it more.

Thanks,
Adam
