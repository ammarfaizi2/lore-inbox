Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWCVVzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWCVVzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbWCVVza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:55:30 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:21126 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932242AbWCVVza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:55:30 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  0/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 14:55:26 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221455.26230.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  I recently changed the interface along
with pnp_register_driver(), but forgot to update the callers of
pnp_register_card_driver().

Several of these patches also fix unrelated __init/__devinit issues
found by "make buildcheck".  Most of these are for .probe() methods,
so they shouldn't have caused any problems because I doubt there are
any hot-pluggable PNP sound cards.
