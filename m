Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWFAShF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWFAShF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWFAShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:37:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13110 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750919AbWFAShD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:37:03 -0400
Date: Thu, 1 Jun 2006 20:39:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: State of resume for AHCI?
Message-ID: <20060601183904.GR4400@suse.de>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447F3250.5070101@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2006, Mark Lord wrote:
> The one-line "resume fix" (attached) *might* be all that you need.
> This is in current Linus 2.6.17-rc*-git*

It's a lot more complicated than that, I'm afraid. ahci doesn't even
have the resume/suspend methods defined, plus it needs more work than
piix on resume.

libata should define a default suspend hook for devices that haven't
added their own, to prevent accidents with people trying to suspend
devices that haven't been fixed up. It's a data integrity issue!

-- 
Jens Axboe

