Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVIDMDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVIDMDB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIDMDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:03:01 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3233 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750764AbVIDMDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:03:00 -0400
Date: Sun, 4 Sep 2005 14:00:47 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
Cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [Linux-ATM-General] [ATMSAR] Request for review - update #1
Message-ID: <20050904120047.GA6556@electric-eye.fr.zoreil.com>
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni <g.tomassoni@libero.it> :
[...]
> However, I'm still hearing for your comments about the usefulness of an
> ATMSAR layer.

Afaik all but one pci ADSL modems are out of tree drivers and include various
level of proprietary code. If Duncan is not interested in changing its code,
the usefulness remains to be proven.

The codingstyle is broken. Please read again Documentation/CodingStyle,
remove the redundant typedef and the silly comments ("Reserve header space",
Encode packet into cells", ...).

- &page[strlen(page)] in atmProcRead sucks.
- "return" is not a function.
- consider 'goto' to handle the errors instead of deep nesting
- +const atmsar_aalops_t opsAALR = {
  +       ATM_AAL0,
  +       "raw",
  -> use .foo = baz instead.

drivers/net/*c may give some hint.

--
Ueimor
