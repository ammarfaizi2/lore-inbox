Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTKNWpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 17:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKNWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 17:45:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43663 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262458AbTKNWpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 17:45:49 -0500
Date: Fri, 14 Nov 2003 22:45:48 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
Message-ID: <20031114224548.GM24159@parcelfarce.linux.theplanet.co.uk>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au> <1068787304.4157.8.camel@localhost> <16308.26754.867801.131463@notabene.cse.unsw.edu.au> <20031114101647.GJ32211@marowsky-bree.de> <20031114182927.GA8810@gtf.org> <20031114154423.A5587@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114154423.A5587@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 03:44:23PM -0600, Matt Domsch wrote:
> Any reason why the current partition-mapping code couldn't be extended
> to handle partition detection on a generic block device (which is what
> MD presents I think) instead of a struct gendisk?  Then it wouldn't

Any block_device has a gendisk - md.c ones included.  The problem is where
to put device numbers of partitions.
