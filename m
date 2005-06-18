Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVFRHpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFRHpq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 03:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVFRHpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 03:45:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:16550 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261503AbVFRHpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 03:45:43 -0400
Date: Sat, 18 Jun 2005 11:45:31 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Peter Buckingham <peter@pantasys.com>
Cc: sean.bruno@dsl-only.net, koch@esa.informatik.tu-darmstadt.de,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050618114531.A2523@jurassic.park.msu.ru>
References: <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org> <20050610184815.A13999@jurassic.park.msu.ru> <200506102247.30842.koch@esa.informatik.tu-darmstadt.de> <1118762382.9161.3.camel@home-lap> <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de> <42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap> <42B1E9B2.30504@pantasys.com> <20050617135400.A32290@jurassic.park.msu.ru> <20050617093410.24a58d56.peter@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050617093410.24a58d56.peter@pantasys.com>; from peter@pantasys.com on Fri, Jun 17, 2005 at 09:34:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 09:34:10AM -0700, Peter Buckingham wrote:
> PCI: Cannot allocate resource region 2 of device 0000:41:00.0
> PCI: Failed to allocate mem resource #0:1000000@280000000 for 0000:41:00.0
> PCI: Failed to allocate mem resource #1:10000000@280000000 for 0000:41:00.0
> PCI: Failed to allocate mem resource #2:1000000@280000000 for 0000:41:00.0
						  ^^^^^^^^^

Ouch. We managed to get value > 4G from 32-bit BARs.
Must be a bug somewhere in PCI probing code...

Ivan.
