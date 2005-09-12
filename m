Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVILTSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVILTSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVILTSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:18:00 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:30217 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932155AbVILTR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:17:58 -0400
Date: Mon, 12 Sep 2005 15:14:21 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com, cramerj@intel.com,
       jesse.brandeburg@intel.com, ayyappan.veeraiyan@intel.com,
       mchan@broadcom.com, davem@davemloft.net
Subject: Re: [patch 2.6.13 0/5] normalize calculations of rx_dropped
Message-ID: <20050912191419.GB19644@tuxdriver.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
	john.ronciak@intel.com, ganesh.venkatesan@intel.com,
	cramerj@intel.com, jesse.brandeburg@intel.com,
	ayyappan.veeraiyan@intel.com, mchan@broadcom.com,
	davem@davemloft.net
References: <09122005104858.332@bilbo.tuxdriver.com> <4325CEAB.2050600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4325CEAB.2050600@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 02:53:31PM -0400, Jeff Garzik wrote:

> For e.g. e1000, are we sure that packets dropped by hardware are 
> accounted elsewhere?

The e100 and tg3 patches move the count of those frames to
rx_missed_errors.  e1000 and ixgb were already counting them there in
addition to rx_discards, so they were simply removed from rx_discards.
3c59x was counting other errors in rx_discards, so they were removed
from that count.

John
-- 
John W. Linville
linville@tuxdriver.com
