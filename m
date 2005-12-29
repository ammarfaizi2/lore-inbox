Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVL2R3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVL2R3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVL2R3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 12:29:07 -0500
Received: from cluster1.g-wis.com ([204.250.154.18]:25604 "EHLO
	cluster1.g-wis.com") by vger.kernel.org with ESMTP id S1750902AbVL2R3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 12:29:06 -0500
Thread-Index: AcYMnVuAeTeTywzLQxS8Z9TDSiofhA==
X-Received-From-Address: 66.220.104.32
X-Envelope-From: greg@kroah.com
Date: Wed, 28 Dec 2005 23:17:56 -0800
Content-Transfer-Encoding: 7bit
From: "Greg KH" <greg@kroah.com>
To: "Kumar Gala" <galak@gate.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Content-Class: urn:content-classes:message
Importance: normal
Subject: Re: pci_scan_bridge and cardbus controllers?
Message-ID: <20051229071756.GD8863@kroah.com>
References: <Pine.LNX.4.44.0512141311140.14530-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0512141311140.14530-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 29 Dec 2005 17:29:00.0665 (UTC) FILETIME=[5B3B4E90:01C60C9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 01:45:30PM -0600, Kumar Gala wrote:
> in pci_fixup_parent_subordinate_busnr() we will only reassign bus numbers 
> if pcibios_assign_all_busses() returns 1.
> 
> If we got to pci_fixup_parent_subordinate_busnr() and
> pcibios_assign_all_busses() returns 0, should we not print out some
> warning since we most likely got here because the bios didn't init things
> properly?
> 
> I came across this on an embedded system in which we had a cardbus 
> controller behind a P2P bridge.  The bios did not reserve any bus numbers 
> for the cardbus controller like linux does.  So I ended up with:

Ick.  Perhaps the pcmcia developers would know better what they want to
have done here?  Try asking on their list :)

thanks,

greg k-h
