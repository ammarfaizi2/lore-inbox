Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWDSNwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWDSNwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWDSNwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:52:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21603 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750770AbWDSNwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:52:20 -0400
Date: Wed, 19 Apr 2006 15:52:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Rachita Kothiyal <rachita@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] Patch to fix cdrom being confused on using kdump
Message-ID: <20060419135232.GK614@suse.de>
References: <20060407135714.GA25569@in.ibm.com> <20060409102942.GI3859@suse.de> <20060411153114.GA5255@in.ibm.com> <20060411170357.GR4791@suse.de> <20060412112933.GA6204@in.ibm.com> <20060419132918.GA31705@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419132918.GA31705@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19 2006, Rachita Kothiyal wrote:
> On Wed, Apr 12, 2006 at 04:59:33PM +0530, Rachita Kothiyal wrote:
> > 
> > I actually tried just reading the status register and then returning
> > ide_stopped. It seemed to be working fine, just that there appears 
> > a 'status error' message while booting:
> > 
> > <snippet>
> > ide0: start_request: current=0xffff8100035cba68
> > hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > ide: failed opcode was: unknown
> > hda: drive not ready for command
> > </snippet>
> 
> Hi Jens,
> 
> Instead of reading the status register and returning ide_stopped
> from the handler, which was resulting in the 'status error', I 
> tried ending the request and returning ide_stopped when the drive
> is in a confused state. Using this I dont see the status error.
> 
> Following is the patch, kindly review.

This looks a lot more appropriate! Thanks for following through on this.

-- 
Jens Axboe

