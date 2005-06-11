Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVFKK1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVFKK1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 06:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVFKK1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 06:27:23 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:31636 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261677AbVFKK1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 06:27:14 -0400
Date: Sat, 11 Jun 2005 14:26:58 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050611142658.A4952@jurassic.park.msu.ru>
References: <20050611053331.9203.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050611053331.9203.qmail@science.horizon.com>; from linux@horizon.com on Sat, Jun 11, 2005 at 05:33:31AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 05:33:31AM -0000, linux@horizon.com wrote:
> Actually, that's not possible, because no difference is permitted.

Not possible on only on _real_ PCI bus.

Example: virtually every laptop has mobile bridge and ISA/LPC/whatever
bridge on the same bus segment. Both are subtractive decode devices -
impossible situation from classic PCI point of view. But it's just
happens because it's _not_ PCI but some proprietary bus, even if it looks
like PCI from software point of view. And sort of priority decode is
certainly takes place there.

Ivan.
