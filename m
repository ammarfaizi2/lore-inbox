Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUHBOgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUHBOgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUHBOgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:36:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39401 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266554AbUHBOeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:34:08 -0400
Date: Mon, 2 Aug 2004 16:33:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Andreas Metzler <lkml-2003-03@downhill.at.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Message-ID: <20040802143330.GY10496@suse.de>
References: <20040730193651.GA25616@bliss> <cehqak$1pq$1@sea.gmane.org> <20040801155753.GA13702@suse.de> <200408020945.05297.tabris@tabris.net> <20040802135615.GX10496@suse.de> <celiub$3bn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <celiub$3bn$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2004, Andreas Metzler wrote:
> Jens Axboe <axboe@suse.de> wrote:
> [...] 
> > just says that open-by-device name is unintentional, it doesn't give you
> > warnings on the transport.
> > 
> > So in short (and repeating): don't use ATAPI (CDROM_SEND_PACKET), it
> > sucks. Use SG_IO (which means using open-by-device, which works at least
> > as well as the stupid faked ATAPI bus/id/lun crap and has the much
> > better transport). Don't compare apples and oranges.
> 
> FWIW cdrecord's author prefers dev=ATA:x,y,z, which uses SG_IO *and* gets
> rid of the open-by-device-warning.

(don't trim linux-kernel cc lists!)

Well good for him, that's why he didn't drop that idiotic warning. I
think the x,y,z naming for ATAPI devices is utter stupidity.

-- 
Jens Axboe

