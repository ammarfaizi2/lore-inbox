Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWF2Ihj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWF2Ihj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 04:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWF2Ihj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 04:37:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59069 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751400AbWF2Ihh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 04:37:37 -0400
Subject: Re: [PATCH 000 of 006] raid5: Offload RAID operations to a
	workqueue
From: Arjan van de Ven <arjan@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
In-Reply-To: <1151519032.2232.62.camel@dwillia2-linux.ch.intel.com>
References: <1151519032.2232.62.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 10:37:29 +0200
Message-Id: <1151570249.3122.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 11:23 -0700, Dan Williams wrote:
> This patch set is a step towards enabling hardware offload in the
> md-raid5 driver.  These patches are considered experimental and are not
> yet suitable for production environments.
> 
> As mentioned, this patch set is the first step in that it moves work
> from handle_stripe5 to a work queue.  

Hi,

since using work queues involve more context switches than doing things
inline... have you measured the performance impact of your changes? If
so... was there any impact that you could measure, and how big was that?

Greetings,
    Arjan van de Ven

