Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWBBUgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWBBUgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWBBUgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:36:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:268 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932221AbWBBUgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:36:43 -0500
Date: Thu, 2 Feb 2006 21:39:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
Message-ID: <20060202203904.GI4215@suse.de>
References: <43DEA195.1080609@tmr.com> <20060201210433.GC8552@ucw.cz> <43E2602C.2090008@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E2602C.2090008@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02 2006, Bill Davidsen wrote:
> The question is still why not make all devices look like SCSI, and use 

Because it's a really bad idea? Right now we have a few storage drivers
that don't use SCSI, that number will increase in the future.

The fact that lots of drivers use the SCSI stack even if they didn't
have to is mainly because the SCSI layer had all those handy features
that they all needed. During 2.5 and 2.6 we moved a lot of that
functionality transparently to the block layer instead. As we complete
that work, it would be just as easy to write a native block driver
instead of a SCSI LLD. libata is one such example.

-- 
Jens Axboe

