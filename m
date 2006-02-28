Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWB1OqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWB1OqB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWB1OqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:46:00 -0500
Received: from rtr.ca ([64.26.128.89]:31932 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751002AbWB1OqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:46:00 -0500
Message-ID: <44046222.4090008@rtr.ca>
Date: Tue, 28 Feb 2006 09:45:54 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fixup ahci suspend / resume
References: <44045FB1.5040408@suse.de>
In-Reply-To: <44045FB1.5040408@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke wrote:
> Hi all,
> 
> the current ahci doesn't handle suspend / resume cycles too well.
> On certain machines the disk just locks up and refuses to work after a
> resume.
> 
> This is due to a initialisation error after resume; ahci has fo[u]r
> registers containing DMA addresses (which are obviously allocated by the
> kernel). Of course there is no guarantee that these addresses are
> unchanged across reboots. So ahci loads the suspended image, and after
> the suspended image is started the driver is presented with different
> DMA addresses, whereas the chip still uses the original ones.
> 
> This patch rearranges the suspend / resume code to properly initialise
> those registers after a resume. It also contains some initialisation
> fixes to make the driver behave more spec-compliant.
..

Is ahci the *only* interface afflicted with this problem?
