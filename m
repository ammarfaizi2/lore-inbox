Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUEZNHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUEZNHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265616AbUEZNDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:03:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62890 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265607AbUEZND0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:03:26 -0400
Date: Wed, 26 May 2004 15:03:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040526130319.GR5322@suse.de>
References: <20040522013636.61efef73.akpm@osdl.org> <20040526124158.GA3679@h55p111.delphi.afb.lu.se> <20040526124944.GQ5322@suse.de> <20040526125914.GB2629@chernushka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526125914.GB2629@chernushka>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26 2004, Anders Gustafsson wrote:
> On Wed, May 26, 2004 at 02:49:44PM +0200, Jens Axboe wrote:
> > But they need to be bisabled, since -o barrier doesn't work on SCSI yet.
> > Only non-data tagged flushes are supported, those from
> > blkdev_issue_flush().
> 
> :(
> 
> Is the problem in the scsi drivers or at a higher level? Would really
> like to have them unbisabled, got a huge speed improvement in a
> logging-application with barriers when tested on IDE.

The error handling needs some work to safely enbable it on SCSI. Will
happen soonish. Additionally, low level drivers need to be updated. This
last step should not be too bad, though.

-- 
Jens Axboe

