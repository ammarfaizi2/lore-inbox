Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVCRDky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVCRDky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 22:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVCRDkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 22:40:46 -0500
Received: from thunk.org ([69.25.196.29]:53188 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261449AbVCRDje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 22:39:34 -0500
Date: Thu, 17 Mar 2005 22:39:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, "Brown, Len" <len.brown@intel.com>,
       Volker Braun <volker.braun@physik.hu-berlin.de>
Subject: Re: [PATCH 2/2] Thinkpad Suspend Powersave: Add D2 power saving code for Thinkpads with Radeon video chipsets
Message-ID: <20050318033928.GD4851@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-thinkpad@linux-thinkpad.org,
	"Brown, Len" <len.brown@intel.com>,
	Volker Braun <volker.braun@physik.hu-berlin.de>
References: <3.518178082@mit.edu> <1111015144.15510.47.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111015144.15510.47.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 10:19:04AM +1100, Benjamin Herrenschmidt wrote:
> You probably want to remove the bit that does
> 
> 	OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
> 
> Or you'll lose TV output :)

I'm not using TV output, and the original patch stated:

> > +		/* Power down TV DAC, that saves a significant amount of power,
> > +		 * we'll have something better once we actually have some TVOut
> > +		 * support
> > +		 */

I suppose I should renable the TV DAC and see how much power it
actually consumes if I enable it.  It would seem to me that we should
have a way that we can power down whatever parts of the video chipset
that we're not using.  (For example if I don't have anything connected
to the VGA output, it would be good if we could power that down too...)

						- Ted
