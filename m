Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWFAUTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWFAUTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWFAUTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:19:19 -0400
Received: from gw.goop.org ([64.81.55.164]:29377 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965295AbWFAUTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:19:18 -0400
Message-ID: <447F4BC2.8060808@goop.org>
Date: Thu, 01 Jun 2006 13:19:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Subject: Re: State of resume for AHCI?
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca> <20060601183904.GR4400@suse.de>
In-Reply-To: <20060601183904.GR4400@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> It's a lot more complicated than that, I'm afraid. ahci doesn't even
> have the resume/suspend methods defined, plus it needs more work than
> piix on resume.
>   
Hannes Reinecke's patch implements those functions, basically by 
factoring out the shutdown and init code and calling them at 
suspend/resume time as well.

Is that correct/sufficient?  Or should something else be happening?

    J
