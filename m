Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUG0S3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUG0S3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUG0S3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:29:05 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:62701 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266538AbUG0S3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:29:03 -0400
Date: Tue, 27 Jul 2004 20:27:50 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, akpm@osdl.org, rml@ximian.com, greg@kroah.com
Subject: Re: [RFC][PATCH] driver model and sysfs support for PCMCIA (1/3)
Message-ID: <20040727182750.GA7884@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk, akpm@osdl.org, rml@ximian.com, greg@kroah.com
References: <20040628200224.GE5175@neo.rr.com> <20040629190948.GA8659@dominikbrodowski.de> <20040705224704.GA4090@neo.rr.com> <20040719080237.GB9494@dominikbrodowski.de> <20040726135313.GB3219@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726135313.GB3219@neo.rr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 01:53:13PM +0000, Adam Belay wrote:
> I agree that the current resources_ready flag could create potential problems.
> I've created another patch against the previous three that removes its usage,
> and relies entirely on DS_BIND_REQUEST.  Devices are now removed but never
> added during hardware events.  As for "hotplug", I was just trying to create
> a complete driver model implementation.  I don't expect it to be used much now,
> but it is an official driver model feature.

The problem are the "values" you export by the hotplug call: if your patch
is merged "as is", then the values you make available to userspace will need
to be supported for a long time, even if this means it'll cause difficulties
once pcmcia becomes fully integrated into the driver model.

	Dominik
