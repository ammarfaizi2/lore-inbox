Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTDFPwf (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTDFPwe (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:52:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4519 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263025AbTDFPwc (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 11:52:32 -0400
Date: Sun, 6 Apr 2003 18:04:09 +0200
From: Jens Axboe <axboe@suse.de>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 48-bit lba a bit further
Message-ID: <20030406160409.GP786@suse.de>
References: <1049639724.962.7.camel@dhcp22.swansea.linux.org.uk> <200304061547.h36FlvbL000563@81-2-122-30.bradfords.org.uk> <20030406155941.GO786@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406155941.GO786@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06 2003, Jens Axboe wrote:
> On Sun, Apr 06 2003, John Bradford wrote:
> > I originally thought that we might only be honouring 512Kb requests
> > for blocks over the 28-bit limit, which Jens corrected me on, but
> > maybe we *should* only do 512Kb requests on high block number, where
> > we have to use 48-bit anyway.
> 
> That makes little sense in practice, and is not currently even doable
> within the block layer.  You got the limits wrong, btw, it's 128kb max
> for 28-bit. A single 512KiB request will have a lower per-kb overhead
> with 48-bit lba than a single 128kb on 28-bit would.

I should mention that the 512KiB number is one I chose, as a good large
request size. You could as high as 32MiB.

-- 
Jens Axboe

