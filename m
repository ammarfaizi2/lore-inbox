Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVBVGwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVBVGwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVBVGwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:52:05 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:45593 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262219AbVBVGwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:52:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RkPckf9GvAh1Zm+ys3QiPcK6PM+ge25KOOj+p+rZGgxz524S3tyvF/6kwuI8TKFANB4XxqCpFP7FmDPMU3YmQElS01jqZZ35w7vOjkTPEv2T4RJo2fXSnwU3o6jXTrGAon52YC0q1h5zr8SCHrvpLrfRki5/IJTrjAN3oxfNY1Q=
Message-ID: <9e47339105022122526338b2c9@mail.gmail.com>
Date: Tue, 22 Feb 2005 01:52:02 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
Cc: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <1109053960.5326.91.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <a728f9f9050221205634a3acf0@mail.gmail.com>
	 <1109049217.5412.79.camel@gaston>
	 <9e4733910502212203671eec73@mail.gmail.com>
	 <1109053960.5326.91.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the kernel need to keep a bit that says the device has been
posted, don't do it again? Should removing/inserting a driver cause a
repost? I was going to add bit in pci_dev that tracks the reset status
so that it will persist across unloads. Do we have code to tell if
hardware needs a reset without the tracking bit?

On the x86 DRM will run without fbdev loaded. So DRM needs to also be
able to do the post and well as fbdev. Or we can just leave the old
drivers alone and only implement this in a merged fbdev/drm driver?

When current X loads it's going to reset the cards again, that may
stomp anything the driver has set up.

-- 
Jon Smirl
jonsmirl@gmail.com
