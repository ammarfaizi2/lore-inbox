Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTHZOdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbTHZOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:32:59 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:59410 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261625AbTHZOce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:32:34 -0400
Date: Tue, 26 Aug 2003 15:32:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: dougg@torque.net, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ballen@gravity.phys.uwm.edu
Subject: Re: [2.6.0-test4] blocking access to mounted scsi devices
Message-ID: <20030826153228.A26979@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@steeleye.com>, dougg@torque.net,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	ballen@gravity.phys.uwm.edu
References: <3F49B515.6010107@torque.net> <20030825130822.A4258@infradead.org> <3F4B3482.4060304@torque.net> <1061906937.1830.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061906937.1830.11.camel@mulgrave>; from James.Bottomley@steeleye.com on Tue, Aug 26, 2003 at 09:08:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 09:08:54AM -0500, James Bottomley wrote:
> Hang on, that's not the way it's supposed to work.
> 
> Mount should be on partition devices (like /dev/sda1) whereas the tools
> should be on whole disc devices (like /dev/sda).  I thought we'd agreed
> that even opening a partition exclusively wouldn't affect the ability to
> open the whole disc device (but opening the whole disc device
> exclusively would block access to all partitions).

Linus accepted a patch from Neil Brown in -test4 that changes this.

