Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTFRNk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 09:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265166AbTFRNk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 09:40:56 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:56068 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265165AbTFRNkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 09:40:55 -0400
Subject: Re: 2.5.70-mm9
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Mingming Cao <cmm@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20030618003838.06144cf9.akpm@digeo.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<3EEAD41B.2090709@us.ibm.com> <20030614010139.2f0f1348.akpm@digeo.com>
	<1055637690.1396.15.camel@w-ming2.beaverton.ibm.com>
	<20030614232049.6610120d.akpm@digeo.com>
	<1055920382.1374.11.camel@w-ming2.beaverton.ibm.com> 
	<20030618003838.06144cf9.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2003 08:54:44 -0500
Message-Id: <1055944486.2075.9.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 02:38, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > I re-run the many fsx tests with feral driver on 2.5.70mm9, ext3
> >  fileystems, on deadline scheduler and as scheduler respectively.  Both
> >  tests passed.  They were running for more than 24 hours without any
> >  problems. So it could be a bug in the device driver that I used
> >  before(QLA2xxx V8).  Before the fsx tests failed on ext3 on either
> >  deadline scheduler or as scheduler.
> 
> Well it could be a bug in the driver, or it could be a bug in the generic
> block/iosched area which was just triggered by the particular way in which
> that driver exercises the core code.
> 
> James, do we have the latest-and-greatest version of the qlogic driver
> in-tree?  ISTR that there's an update out there somewhere?

I'm still currently keeping the qlogic and feral drivers out of tree. 
Feral because Matthew Jacob thinks its not ready yet and Qlogic because
I was waiting for the must-fix list (I'll prod hch again for this).

You can get the current qlogic driver at

  http://sourceforge.net/projects/linux-qla2xxx/

And I will update the BK tree at linux-scsi.bkbits.net

James


