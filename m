Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTIWTKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTIWTJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:09:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:17167 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262197AbTIWTI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:08:26 -0400
Date: Tue, 23 Sep 2003 20:08:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
Message-ID: <20030923200824.A24300@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <10642734271572@kroah.com> <1064273428551@kroah.com> <20030923091617.B10818@infradead.org> <20030923161929.GB4402@kroah.com> <20030923172258.B19880@infradead.org> <20030923190440.GA5205@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030923190440.GA5205@kroah.com>; from greg@kroah.com on Tue, Sep 23, 2003 at 12:04:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 12:04:40PM -0700, Greg KH wrote:
> Heh, good point.  Ok, I dug out a box that uses a isa i2c adapter and
> tested the patch below.  As the chip drivers are using request_region
> properly, taking this check out of i2c-sensor.c makes sense.

Looks better already, but I really wonder WTF this i2c_check_addr
thing is.  It looks at least as racy as check_region..
