Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVAUDA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVAUDA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 22:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVAUDA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 22:00:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262249AbVAUDAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 22:00:06 -0500
Date: Thu, 20 Jan 2005 22:00:03 -0500
From: Dave Jones <davej@redhat.com>
To: Marco Cipullo <cipullo@libero.it>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Typo in [AGPGART] i915GM support patch
Message-ID: <20050121030003.GF32430@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marco Cipullo <cipullo@libero.it>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <41EFE05E.1050501@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EFE05E.1050501@libero.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 05:46:22PM +0100, Marco Cipullo wrote:
 > - if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB)
 > + if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
 > +     agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB)
 >  	gtt_entries = MB(48) - KB(size);
 >  else
 >  	gtt_entries = 0;
 >  break;
 > Peraphs is:
 > 
 > @@ -415,14 +415,16 @@
 >  			break;
 >  		case I915_GMCH_GMS_STOLEN_48M:
 >  			/* Check it's really I915G */
 > - if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB)
 > + if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
 > +     agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB)
 >  	gtt_entries = MB(48) - KB(size);
 >  else
 >  	gtt_entries = 0;
 >  break;
 > 
 > The same applies few lines below....

Duh, yes. Thanks.
Fix sent to Linus.

		Dave

