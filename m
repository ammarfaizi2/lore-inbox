Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTLRTcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbTLRTcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:32:35 -0500
Received: from rtv5.czechbone.net ([212.96.160.67]:49616 "EHLO main.rtv5.cz")
	by vger.kernel.org with ESMTP id S265291AbTLRTcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:32:32 -0500
Message-ID: <3FE200CA.2080705@tiscali.cz>
Date: Thu, 18 Dec 2003 20:32:26 +0100
From: Milos Prudek <milos.prudek@tiscali.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mount Rainier in 2.6
References: <3FE16489.9060006@tiscali.cz> <20031218083530.GP2495@suse.de> <20031218114000.GB2069@suse.de>
In-Reply-To: <20031218114000.GB2069@suse.de>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's a patch, it's received a little testing. Let me know if it works
> for you. I'm also attaching a slightly updated cdmrw tool.

Patch applied successfully. Compilation failed. This is with the default 
kernel config (2.6.0 config as shipped). The only change was changing 
reiserfs from Module to built-in, and removing all other filesystems 
except ext2 and reiserfs.

Here's the error:

   CC [M]  drivers/scsi/sr.o
drivers/scsi/sr.c:112: error: `CDC_MRW_R' undeclared here (not in a 
function)
drivers/scsi/sr.c:112: error: initializer element is not constant
drivers/scsi/sr.c:112: error: (near initialization for `sr_dops.capability')
drivers/scsi/sr.c: In function `get_capabilities':
drivers/scsi/sr.c:770: error: `scsi_CDs' undeclared (first use in this 
function)
drivers/scsi/sr.c:770: error: (Each undeclared identifier is reported 
only once
drivers/scsi/sr.c:770: error: for each function it appears in.)
drivers/scsi/sr.c:770: error: `i' undeclared (first use in this function)
drivers/scsi/sr.c:770: error: `mrw_write' undeclared (first use in this 
function)
drivers/scsi/sr.c:696: warning: unused variable `mwr_write'
make[2]: *** [drivers/scsi/sr.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


-- 
Milos Prudek

