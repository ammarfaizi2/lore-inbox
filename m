Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTKTLcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 06:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTKTLcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 06:32:52 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:6922 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261614AbTKTLcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 06:32:51 -0500
Date: Thu, 20 Nov 2003 11:32:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zinx Verituse <zinx@epicsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] cuecat serio driver for linux 2.6.0-test9
Message-ID: <20031120113249.A30030@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zinx Verituse <zinx@epicsol.org>, linux-kernel@vger.kernel.org
References: <20031120014514.GA4573@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031120014514.GA4573@bliss>; from zinx@epicsol.org on Wed, Nov 19, 2003 at 07:45:14PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 07:45:14PM -0600, Zinx Verituse wrote:
> Well, my cuecat driver is ready for testing.
> 
> http://zinx.xmms.org/cuecat/cuecat-2.6-0.0.2.tar.gz
> 
> It does not use the same output format as the driver floating around
> for 2.2.x/2.4.x kernels.
> 
> It currently requires a patch which changes the order serio drivers
> are searched in (the newest driver is searched first now), and adds
> a function to walk through the serio port list.
> 
> I'm hoping the patch will be included in to the kernel at some point
> in time -- It's available separately at:
> 	http://zinx.xmms.org/cuecat/linux-2.6.0-test9-serio.diff
> 
> The driver has some pitfalls, such as standing between -all- serio
> devices capable of supporting a cuecat, and not just the ones with
> a cuecat on them (And it has no way to specify which ports to use),
> but hopefully I'll think of a good way to fix that before 0.0.3.
> 
> The major number is dynamicly allocated -- If you aren't using devfs,
> check /proc/devices.
> The minor number for reading all cuecats is 0, and the minor number
> for individual cuecats is their [driver-assigned] index plus 1.
> Recommended names are:
> 	/dev/cuecat/cuecats
> 	/dev/cuecat/0
> 	/dev/cuecat/1
> and so on.

Hmm?  A 2.6 input driver shouldn't create devices bz itself but rather use
the input core to communicated with the upper drivers like evdev or moused..

