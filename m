Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVILQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVILQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVILQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:45:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:17619 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932087AbVILQp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:45:57 -0400
Date: Mon, 12 Sep 2005 09:45:48 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Douglas Gilbert <dougg@torque.net>, Christoph Hellwig <hch@infradead.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050912164548.GB11455@us.ibm.com>
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126537041.4825.28.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:57:21AM -0500, James Bottomley wrote:

> be free to increase it if necessary.  Note: you do actually need either
> an array with more than two levels of nesting actually to need the
> increase and no-one actually seems to have one of these yet.

That is not correct, I posted before on this, the address method is in the
high bits of the 8 byte LUN and tells how to "interpret" the LUN value.
You can't convert from an int to 8 byte LUN (without any other
information) and set these bits. See SAM-4 in (or near) section 4.9.7.

So some storage devices that want to use addressing methods other than 00b
don't because we do not have 8 byte LUN support in linux, and then we have
other problems because of this.

-- Patrick Mansfield
