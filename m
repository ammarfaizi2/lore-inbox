Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVF1VSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVF1VSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVF1VRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:17:09 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:39307 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261301AbVF1UDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:03:35 -0400
Date: Wed, 29 Jun 2005 00:03:00 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: rajesh.shah@intel.com, gregkh@suse.de, ak@suse.de, len.brown@intel.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, acpi-devel@lists.sourceforge.net
Subject: Re: [patch 2/2] i386/x86_64: collect host bridge resources v2
Message-ID: <20050629000300.A26118@jurassic.park.msu.ru>
References: <20050602224147.177031000@csdlinux-1> <20050602224327.051278000@csdlinux-1> <20050628155152.A24551@jurassic.park.msu.ru> <1119982914.19258.6.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1119982914.19258.6.camel@whizzy>; from kristen.c.accardi@intel.com on Tue, Jun 28, 2005 at 11:21:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 11:21:54AM -0700, Kristen Accardi wrote:
> I gave this patch a try (against mm2), and found that I now get many
> errors on boot up complaining about not being able to allocate PCI
> resources due to resource collisions, and then the system begins to
> complain about lost interrupts on hda, and is never able to mount the
> root filesystem.

Well, I'm not surprised. :-(
Probably there is a conflict between e820 map and root bus ranges
reported by ACPI. I think that it would be better to just drop
gregkh-pci-pci-collect-host-bridge-resources-02.patch rather than
try to fix it, at least until such conflicts can be resolved in
a sane way.

Ivan.
