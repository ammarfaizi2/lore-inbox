Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbTDFPsH (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbTDFPsH (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:48:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52133 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263020AbTDFPsG (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 11:48:06 -0400
Date: Sun, 6 Apr 2003 17:59:41 +0200
From: Jens Axboe <axboe@suse.de>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 48-bit lba a bit further
Message-ID: <20030406155941.GO786@suse.de>
References: <1049639724.962.7.camel@dhcp22.swansea.linux.org.uk> <200304061547.h36FlvbL000563@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304061547.h36FlvbL000563@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06 2003, John Bradford wrote:
> I originally thought that we might only be honouring 512Kb requests
> for blocks over the 28-bit limit, which Jens corrected me on, but
> maybe we *should* only do 512Kb requests on high block number, where
> we have to use 48-bit anyway.

That makes little sense in practice, and is not currently even doable
within the block layer.  You got the limits wrong, btw, it's 128kb max
for 28-bit. A single 512KiB request will have a lower per-kb overhead
with 48-bit lba than a single 128kb on 28-bit would.

-- 
Jens Axboe

