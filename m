Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVBKGVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVBKGVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVBKGVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:21:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48797 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262194AbVBKGVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:21:01 -0500
Date: Fri, 11 Feb 2005 01:21:00 -0500
From: Dave Jones <davej@redhat.com>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
Message-ID: <20050211062100.GB1782@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
References: <420C4B9A.6020900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420C4B9A.6020900@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 07:07:22AM +0100, Marcus Hartig wrote:

 > the agpgart backend is now always compiled in and selected with 2.6.11-rc3 
 > x86_64. I can delete or disable it in the config, it is always back written.

probably you have selected IOMMU, which is dependant on it.

 > Is this the default future behaviour?

This is how it's always been.

 > The eg Nforce3 AGP is on a normal desktop so slow on 2D and also in 3D mode
 > a lot slower and all nvidia kernel driver users can not more use the really
 > faster nv_agp.

This surprises me, especially considering the in-kernel nvidia-agp driver
was actually written by NVidia. Are there any agp error messages in
your dmesg / X log ?

How big a speed difference do you notice with the two gart drivers?

		Dave

