Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbTFRHX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 03:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265073AbTFRHX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 03:23:57 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:58632 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265071AbTFRHX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 03:23:56 -0400
Date: Wed, 18 Jun 2003 00:38:38 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.5.70-mm9
Message-Id: <20030618003838.06144cf9.akpm@digeo.com>
In-Reply-To: <1055920382.1374.11.camel@w-ming2.beaverton.ibm.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<3EEAD41B.2090709@us.ibm.com>
	<20030614010139.2f0f1348.akpm@digeo.com>
	<1055637690.1396.15.camel@w-ming2.beaverton.ibm.com>
	<20030614232049.6610120d.akpm@digeo.com>
	<1055920382.1374.11.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jun 2003 07:37:52.0882 (UTC) FILETIME=[86AE5D20:01C3356C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I re-run the many fsx tests with feral driver on 2.5.70mm9, ext3
>  fileystems, on deadline scheduler and as scheduler respectively.  Both
>  tests passed.  They were running for more than 24 hours without any
>  problems. So it could be a bug in the device driver that I used
>  before(QLA2xxx V8).  Before the fsx tests failed on ext3 on either
>  deadline scheduler or as scheduler.

Well it could be a bug in the driver, or it could be a bug in the generic
block/iosched area which was just triggered by the particular way in which
that driver exercises the core code.

James, do we have the latest-and-greatest version of the qlogic driver
in-tree?  ISTR that there's an update out there somewhere?
