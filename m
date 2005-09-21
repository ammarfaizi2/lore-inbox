Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVIUSAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVIUSAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVIUSAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:00:36 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:41695 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751155AbVIUSAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:00:35 -0400
Date: Wed, 21 Sep 2005 11:11:51 -0700
From: thockin@hockin.org
To: "Campbell, Shawn" <scampbell@malone.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: PCI Express or TG3 issue
Message-ID: <20050921181151.GA809@hockin.org>
References: <15F23A40330F5742B268A041F003055705D2A3@srv-elijah1.malone.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15F23A40330F5742B268A041F003055705D2A3@srv-elijah1.malone.int>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 01:34:58PM -0400, Campbell, Shawn wrote:
> hexdump /proc/bus/pci/02/00.0
> 
> 0000010 0004 d000 0001 8000 0000 0000 0000 0000
             ^ means 64-bit memory BAR

This device is claiming that it has a 64-bit base-address which has been
programmed by BIOS to be at 0x80000001d0000000.

I suspect that the 4 bytes at offset 0x14 want to be 0.  The address
0xd0000000 jives with the rest of your PCI listing.

I don't know where that extra 0x80000001 comes from, but it's pretty
clearly wrong.  BIOS bug?  I can't see where kernel would have boned that
up *that* badly.
