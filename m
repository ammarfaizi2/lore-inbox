Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTDFPWQ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTDFPWQ (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:22:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22670
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263011AbTDFPWP (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:22:15 -0400
Subject: Re: [PATCH] take 48-bit lba a bit further
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304061332.h36DWnaD000165@81-2-122-30.bradfords.org.uk>
References: <200304061332.h36DWnaD000165@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049639724.962.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 15:35:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 14:32, John Bradford wrote:
> Then, don't we want to be using 48-bit lba all the time on compatible devices
> instead of falling back to 28-bit when possible to save a small amount of
> instruction overhead?  (Or is that what we're doing already?  I haven't really
> had the time to follow this thread).

The overhead of the double load of the command registers is microseconds so it
is actually quite a lot, especially since IDE lacks TCQ so neither end of the
link is doing *anything* useful. SCSI has similar problems on older SCSI with 
command sending being slow, but the drive is at least doing other commands during
this.

