Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVJTOdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVJTOdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 10:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVJTOdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 10:33:51 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:16908 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932125AbVJTOdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 10:33:50 -0400
Date: Thu, 20 Oct 2005 10:33:29 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       pp@ee.oulu.fi
Subject: Re: [patch 2.6.14-rc4] b44: alternate allocation option for DMA descriptors
Message-ID: <20051020143326.GB25010@tuxdriver.com>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jgarzik@pobox.com, pp@ee.oulu.fi
References: <10182005213059.12243@bilbo.tuxdriver.com> <1129792626.7620.248.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129792626.7620.248.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 05:17:05PM +1000, Benjamin Herrenschmidt wrote:

> So basically, what you are doing is: if allocation fails, you try to get
> memory using GFP_KERNEL. If it happens to be in the low 2Gb of memory,
> use it, if not, drop it.
> 
> Did I get that right ?

Yes, that is basically correct.  I wish I had something more clever
than that...suggestions welcome...

John
-- 
John W. Linville
linville@tuxdriver.com
