Return-Path: <linux-kernel-owner+w=401wt.eu-S1751473AbXAOUcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXAOUcl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXAOUcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 15:32:41 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:43686 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbXAOUck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 15:32:40 -0500
Date: Mon, 15 Jan 2007 20:32:17 +0000
From: David Hollis <dhollis@davehollis.com>
Subject: Re: 2.6.20-rc4-mm1 USB (asix) problem
In-reply-to: <20070115195024.GA8135@pool-71-123-103-45.spfdma.east.verizon.net>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <1168893137.19899.109.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
	<1168889276.19899.105.camel@dhollis-lnx.sunera.com>
	<20070115195024.GA8135@pool-71-123-103-45.spfdma.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 14:50 -0500, Eric Buddington wrote:

> The asix_write_cmd argument in question did indeed change from 0 to 1
> between 2.6.20-rc3-mm1 and -rc4-mm1. I'll change it back, rebuild,
> and test. Probably tomorrow.
> 

Interesting.  It would really be something if your devices happen to
work better with 0.  Wouldn't make much sense at all unfortunately.  If
0 works, could you also try setting it to 2 or 3?  The PHY select value
is a bit field with the 0 bit being to select the onboard PHY, and 1 bit
being to 'auto-select' the PHY based on link status.  The data sheet
indicates that 3 should be the default, but all of the literature I have
seen from ASIX says to write a 1 to it.

And FWIW, that change for setting it to 1 fixed a bunch of broken
adapters, including mine.

-- 
David Hollis <dhollis@davehollis.com>

