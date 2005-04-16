Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVDPQmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVDPQmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 12:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVDPQmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 12:42:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30616 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262699AbVDPQl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 12:41:58 -0400
Date: Sat, 16 Apr 2005 12:41:55 -0400
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: "ross@lug.udel.edu" <ross@jose.lug.udel.edu>, linux-kernel@vger.kernel.org
Subject: Re: DRM not working with 2.6.11.5
Message-ID: <20050416164155.GA23306@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@gmail.com>,
	"ross@lug.udel.edu" <ross@jose.lug.udel.edu>,
	linux-kernel@vger.kernel.org
References: <20050416070925.GA1237@jose.lug.udel.edu> <21d7e99705041601476a147251@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705041601476a147251@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 06:47:13PM +1000, Dave Airlie wrote:
 > > 
 > > The AGP and DRM modules load fine, but when xdm starts, I have no
 > > direct rendering.
 > > 
 > > The machine is an ASUS A7V8x-x with VIA chipset KT400.  The video card
 > > is a Matrox G400 DualHead.  I've had the exact same video card working
 > > with different motherboards.
 > > 
 > > Here is the only DRM output relevant to AGP/DRM:
 > > 
 > > Linux agpgart interface v0.100 (c) Dave Jones
 > > [drm] Initialized drm 1.0.0 20040925
 > > [drm:drm_fill_in_dev] *ERROR* Cannot initialize the agpgart module.
 > 
 > You didn't load the agp chipset module..
 > it would be nice if it happened automatically...

Adam Jackson was looking into this a few days ago by making
the generic agpgart.o send hotplug events to trigger a load
of the submodules. If he comes up with something I'll throw
it at -mm if it looks sane.

		Dave

