Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWFHHAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWFHHAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWFHHAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:00:07 -0400
Received: from gw.openss7.com ([142.179.199.224]:2238 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932533AbWFHHAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:00:06 -0400
Date: Thu, 8 Jun 2006 01:00:04 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Message-ID: <20060608010004.A12202@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <200606080739.33967.ak@suse.de> <20060608004153.A11953@openss7.org> <200606080851.20232.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606080851.20232.ak@suse.de>; from ak@suse.de on Thu, Jun 08, 2006 at 08:51:20AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Thu, 08 Jun 2006, Andi Kleen wrote:
> 
> Originally because it made assembly too unreadable. Later it was discovered
> it produces smaller code too.
> 

Thank you for the explanation.  But, this brings to mind two other questions:

  Does the option not also make assembly less readable on other architectures?

  If one is interested in smaller code, why not use -Os?

Also, does -fno-reorder-blocks actually defeat __builtin_expect()?
(GCC documentation doesn't really say that.)
