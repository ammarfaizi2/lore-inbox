Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUHBO0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUHBO0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHBO0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:26:48 -0400
Received: from main.gmane.org ([80.91.224.249]:36270 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266539AbUHBO0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:26:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Metzler <lkml-2003-03@downhill.at.eu.org>
Subject: Re: ide-cd problems
Date: Mon, 2 Aug 2004 14:26:19 +0000 (UTC)
Message-ID: <celiub$3bn$1@sea.gmane.org>
References: <20040730193651.GA25616@bliss> <cehqak$1pq$1@sea.gmane.org> <20040801155753.GA13702@suse.de> <200408020945.05297.tabris@tabris.net> <20040802135615.GX10496@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: balrog.logic.univie.ac.at
X-Archive: encrypt
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.4.26-1-k7 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
[...] 
> just says that open-by-device name is unintentional, it doesn't give you
> warnings on the transport.
> 
> So in short (and repeating): don't use ATAPI (CDROM_SEND_PACKET), it
> sucks. Use SG_IO (which means using open-by-device, which works at least
> as well as the stupid faked ATAPI bus/id/lun crap and has the much
> better transport). Don't compare apples and oranges.

FWIW cdrecord's author prefers dev=ATA:x,y,z, which uses SG_IO *and* gets
rid of the open-by-device-warning.
                cu andreas

