Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032123AbWLGMVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032123AbWLGMVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032125AbWLGMVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:21:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37340 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032123AbWLGMVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:21:44 -0500
Message-ID: <45780755.3040404@garzik.org>
Date: Thu, 07 Dec 2006 07:21:41 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] sata_promise: cleanups, take 2
References: <200612060855.kB68th9a024699@harpo.it.uu.se>
In-Reply-To: <200612060855.kB68th9a024699@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch performs two simple cleanups of sata_promise.
> 
> * Remove board_20771 and map device id 0x3577 to board_2057x.
>   After the recent corrections for SATAII chips, board_20771 and
>   board_2057x were equivalent in the driver.
> 
> * Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
>   to compute hotplug_offset in pdc_host_init(). hp->hotplug_offset
>   was used to distinguish 1st and 2nd generation chips in one
>   particular case, but now we have that information in a more
>   general form in hp->flags, so hp->hotplug_offset is redundant.
> 
> Changes since previous submission: rebased on libata-dev #upstream,
> cleaned up hotplug_offset computation based on Tejun's comments,
> expanded hotplug_offset removal rationale.
> 
> This patch does not depend on the pending new EH conversion patch.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied


