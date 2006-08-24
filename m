Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWHXQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWHXQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWHXQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:26:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40358 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751309AbWHXQ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:26:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44EDD29B.1000207@s5r6.in-berlin.de>
Date: Thu, 24 Aug 2006 18:23:55 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
References: <32640.1156424442@warthog.cambridge.redhat.com>
In-Reply-To: <32640.1156424442@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
...
>  (*) Adds dependencies on CONFIG_BLOCK to any configuration item that controls
>      an item that uses the block layer.  This includes:
...
>      (*) The SCSI layer.  As far as I can tell, even SCSI chardevs use the
>      	 block layer to do scheduling.
> 
>      (*) Various block-based device drivers, such as IDE, the old CDROM
>      	 drivers and USB storage.
...

Side note w/o consequence for your patch: usb-storage is not a 
block-based device driver. It is a SCSI low-level provider which happens 
to need symbols from the block layer to adjust parameters of the SCSI 
request queue since there are no fitting abstractions supplied by the 
SCSI mid-level.
-- 
Stefan Richter
-=====-=-==- =--- ==---
http://arcgraph.de/sr/
