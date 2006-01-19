Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWASQZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWASQZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWASQZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:25:33 -0500
Received: from [81.2.110.250] ([81.2.110.250]:57515 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161268AbWASQZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:25:33 -0500
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43CFB747.3000807@rtr.ca>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
	 <43CE1E52.3030907@aitel.hist.no>  <43CE6997.6090005@rtr.ca>
	 <1137605541.29681.13.camel@localhost.localdomain> <43CFB747.3000807@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 16:25:00 +0000
Message-Id: <1137687900.8471.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 10:59 -0500, Mark Lord wrote:
> But the card is a total slug unless the host does 32-bit PIO to/from it.
> Do we have that capability in libata yet?

Very very easy to sort out. Just need a ->pio_xfer method set. Would
then eliminate some of the core driver flags and let us do vlb sync for
legacy hw

