Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWB1POi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWB1POi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWB1POi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:14:38 -0500
Received: from mail.dvmed.net ([216.237.124.58]:57738 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932155AbWB1POh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:14:37 -0500
Message-ID: <440468DB.5060605@pobox.com>
Date: Tue, 28 Feb 2006 10:14:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hannes Reinecke <hare@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fixup ahci suspend / resume
References: <44045FB1.5040408@suse.de>
In-Reply-To: <44045FB1.5040408@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
> Subject: AHCI suspend / resume fixes.
> 
> The current ahci driver has the problem that it doesn't resume properly.
> Or rather, that resuming is unstable.
> Reason being is that AHCI has 4 registers containing the DMA address it
> should write things to. Of course there is no guarantee that Linux has
> assigned the same address to the DMA area across reboots.
> So we should better re-initialize those registers after resume.
> 
> The patch also improves the port_start / port_stop routines to be more
> closely modelled after the spec. This also avoids a nasty msleep(500)
> during initialisation.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>


Seems sane at first glance, but can you please regenerate this against 
libata-dev.git#upstream ?

Upstream 2.6.x doesn't care at all about suspend/resume, and AHCI has 
seen several modifications in #upstream that are waiting for 2.6.17.

	Jeff


