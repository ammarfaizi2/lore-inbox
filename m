Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWFQIXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWFQIXm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 04:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFQIXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 04:23:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49598 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750775AbWFQIXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 04:23:41 -0400
To: Brice Goglin <brice@myri.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, discuss@x86-64.org
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
References: <4493709A.7050603@myri.com> <20060617062840.GD31645@kroah.com>
	<4493AB39.7010409@myri.com>
From: Andi Kleen <ak@suse.de>
Date: 17 Jun 2006 10:23:38 +0200
In-Reply-To: <4493AB39.7010409@myri.com>
Message-ID: <p73ver0p4vp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <brice@myri.com> writes:
> 
> Or we could enable MSI by default on PCI-E chipsets and disable by
> default on non-PCI-E (ie we whitelist non-PCI-E only) ? PCI-E chipsets
> seem to support MSI pretty well.

It looks like at least Serverworks HT1000 has trouble with MSI
too, but it's PCI-Express. But I guess those can be black listed

Also I think Intel has supported it well for a long time so might
want to white list all from VENDOR == Intel.

Blacklisting all old non PCI-E bridges non Intel seems reasonable

It seems AMD 8132 can be made to work, but it needs a special
quirk too and then it can be white listed.

The rules will be relatively complicated I guess, but should
be doable.

-Andi
