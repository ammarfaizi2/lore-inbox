Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbWGNBtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWGNBtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 21:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWGNBtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 21:49:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161170AbWGNBtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 21:49:06 -0400
Date: Thu, 13 Jul 2006 21:48:57 -0400
From: Dave Jones <davej@redhat.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: framebuffer console code triggered might_sleep assertion.
Message-ID: <20060714014856.GA4498@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060707220951.GA3356@redhat.com> <44AF02A3.3010705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AF02A3.3010705@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 08:56:03AM +0800, Antonino A. Daplas wrote:

 > Looks like the printk buffer was flushed on release_console_sem() while
 > the irqs are disabled. But the console (fbcon) thinks that it's still
 > okay to schedule() which triggered might_sleep().
 > 
 > Would the attached patch help? It disables console scheduling before
 > calling the console drivers.

This seemed to do the trick. I've not seen this since applying your patch.

		Dave

-- 
http://www.codemonkey.org.uk
